const fs = require("fs");
const path = require("path");
const dayjs = require("dayjs");

const puppeteer = require("puppeteer");

function ensureDir(dir) {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
}

function stripMarkdown(md = "") {
  return md
    .replace(/\*\*/g, "")
    .replace(/^#+\s*/gm, "")
    .replace(/_/g, "")
    .trim();
}

function pct(p) {
  const n = typeof p === "string" ? parseFloat(p) : Number(p || 0);
  return `${Math.round(n * 100)}%`;
}

function formatInterpretacionIA(texto = "") {
  if (!texto) return "<p>No se encontró interpretación.</p>";
  return texto
    .split(/\n\s*\n/)
    .map((p) => `<p>${stripMarkdown(p.trim())}</p>`)
    .join("");
}

async function generarReporte16pf(payload) {
  const { aspirante, cargo, resultados, interpretacionIA } = payload;

  const outputDir = process.env.REPORTS_DIR || path.resolve("reportes");
  ensureDir(outputDir);

  const fecha = dayjs().subtract(5, "hour").format("YYYY-MM-DD_HH-mm-ss");
  const safeName = (aspirante?.nombre || `aspirante_${aspirante?.id || "s/n"}`)
    .replace(/\s+/g, "_")
    .replace(/[^\w\-_.]/g, "");
  const filename = `reporte_16pf_${safeName}_${fecha}.pdf`;
  const filePath = path.join(outputDir, filename);

  const logoPath = path.resolve(process.cwd(), process.env.PDF_LOGO);
  const logoBase64 = fs.readFileSync(logoPath).toString("base64");
  const logoHtml = `<img src="data:image/png;base64,${logoBase64}" style="height:60px;"/>`;
  const fechaGeneracion = dayjs()
    .subtract(5, "hour")
    .format("DD/MM/YYYY HH:mm");

  const labels = resultados.map((r) => r.descripcion_factor);
  const dataValues = resultados.map((r) =>
    typeof r.porcentaje === "string"
      ? parseFloat(r.porcentaje) * 100
      : r.porcentaje * 100
  );

  const html = `
    <html>
      <head>
        <meta charset="UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
          body { font-family: 'Helvetica','Arial',sans-serif; margin: 40px; color: #333; }
          header { display:flex; align-items:center; justify-content:space-between; border-bottom:3px solid #004080; padding-bottom:10px; margin-bottom:30px; }
          header h1 { font-size:22px; color:#004080; margin:0; text-align:right; flex:1; }
          h2 { font-size:16px; margin-top:30px; color:#004080; border-left:4px solid #004080; padding-left:6px; }
          .datos { margin-bottom:20px; }
          .datos p { margin:4px 0; font-size:12px; }
          table { width:100%; border-collapse: collapse; font-size:11px; margin-top:10px; }
          th, td { border:1px solid #ddd; padding:8px; text-align:left; vertical-align:top; }
          th { background:#004080; color:#fff; font-weight:bold; }
          tr:nth-child(even) { background:#f9f9f9; }
          .interpretacion { margin-top:30px; font-size:12px; text-align:justify; background:#f5f8fc; padding:15px; border-left:4px solid #004080; border-radius:4px; }
          .interpretacion p { margin-bottom:12px; line-height:1.6; }
          .page-break { page-break-before: always; }
          .grafica-container { width:100%; height:400px; }
        </style>
      </head>
      <body>
        <header>
          <div>${logoHtml}</div>
          <h1>Reporte de Resultados 16PF</h1>
        </header>

        <div class="datos">
          <h2>Datos del aspirante</h2>
          <p><b>Nombre:</b> ${aspirante?.nombre || "-"}</p>
          <p><b>Edad:</b> ${aspirante?.edad ?? "-"}</p>
          <p><b>Sexo:</b> ${aspirante?.sexo || "-"}</p>
          <p><b>Cargo al que aspira:</b> ${cargo || "-"}</p>
          <p><b>Fecha de generación:</b> ${fechaGeneracion}</p>
        </div>

        <div class="interpretacion">
          <h2>Interpretación generada por IA</h2>
          ${formatInterpretacionIA(interpretacionIA)}
        </div>
        
         <div class="page-break"></div>
        <h2>Gráfica de Resultados</h2>
        <div class="grafica-container">
          <canvas id="grafica"></canvas>
        </div>

        <div class="page-break"></div>

        <h2>Resultados</h2>
        <table>
          <thead>
            <tr>
              <th>Factor</th>
              <th>Descripción</th>
              <th>Nivel</th>
              <th>%</th>
              <th>Descripción del nivel</th>
            </tr>
          </thead>
          <tbody>
            ${(resultados || [])
              .map(
                (r) => `
              <tr>
                <td>${r.factor ?? ""}</td>
                <td>${r.descripcion_factor ?? ""}</td>
                <td>${r.nivel ?? ""}</td>
                <td>${pct(r.porcentaje)}</td>
                <td>${r.interpretacion ?? ""}</td>
              </tr>`
              )
              .join("")}
          </tbody>
        </table>

       

        <script>
          const ctx = document.getElementById('grafica').getContext('2d');
          new Chart(ctx, {
            type: 'line',
            data: {
              labels: ${JSON.stringify(labels)},
              datasets: [{
                label: 'Porcentaje por Factor',
                data: ${JSON.stringify(dataValues)},
                borderColor: '#004080',
                backgroundColor: 'rgba(0,64,128,0.2)',
                fill: true,
                tension: 0.2,
                pointRadius: 4,
                pointBackgroundColor: '#004080'
              }]
            },
            options: {
              responsive: true,
              maintainAspectRatio: false,
              scales: {
                y: { beginAtZero: true, max: 100 }
              }
            }
          });
        </script>
      </body>
    </html>
  `;

  const browser = await puppeteer.launch({
    headless: "new",
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });
  const page = await browser.newPage();
  await page.setContent(html, { waitUntil: "networkidle0" });
  await page.pdf({
    path: filePath,
    format: "A4",
    printBackground: true,
    margin: { top: "40px", right: "40px", bottom: "40px", left: "40px" },
  });
  await browser.close();

  return filePath;
}

module.exports = { generarReporte16pf };
