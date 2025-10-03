require("dotenv").config();
const axios = require("axios");
const OpenAI = require("openai");
const logger = require("../utils/logger");

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

async function generarInterpretacionGroq(aspirante, resultados, cargo) {
  const factoresTexto = resultados
    .map(
      (f, i) =>
        `${i + 1}. ${f.factor} - ${(f.porcentaje * 100).toFixed(0)}% → ${
          f.interpretacion
        }`
    )
    .join("\n");

  const prompt = `
Eres un psicólogo organizacional experto en el test 16PF. Evalúa el perfil del siguiente aspirante de acuerdo con su resultado en 16 factores, para el cargo especificado. Da un nivel de ajuste: ALTO, MEDIO o BAJO, y justifica con máximo tres párrafos.

Datos del aspirante:
Nombre: ${aspirante.nombre}
Edad: ${aspirante.edad}
Sexo: ${aspirante.sexo}

Cargo aspirado: ${cargo}

Resultados:
${factoresTexto}
`;

  try {
    const response = await axios.post(
      "https://api.groq.com/openai/v1/chat/completions",
      {
        model: process.env.GROQ_MODEL || "llama-3.3-70b-versatile",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.7,
      },
      {
        headers: {
          Authorization: `Bearer ${process.env.GROQ_API_KEY}`,
          "Content-Type": "application/json",
        },
      }
    );

    return {
      texto: response.data.choices[0].message.content,
      modelo: response.data.model,
      tokens_entrada: response.data.usage?.prompt_tokens || 0,
      tokens_salida: response.data.usage?.completion_tokens || 0,
    };
  } catch (error) {
    logger.error(
      "Error en llamada a Groq:",
      error.response?.data || error.message
    );
    throw new Error("Error al generar interpretación IA con Groq");
  }
}

async function generarInterpretacionOpenAI(aspirante, resultados, cargo) {
  const factoresTexto = resultados
    .map(
      (f, i) =>
        `${i + 1}. ${f.factor} - ${(f.porcentaje * 100).toFixed(0)}% → ${
          f.interpretacion
        }`
    )
    .join("\n");

  const prompt = `
Eres un psicólogo organizacional experto en el test 16PF. Evalúa el perfil del siguiente aspirante de acuerdo con su resultado en 16 factores, para el cargo especificado. Da un nivel de ajuste: ALTO, MEDIO o BAJO, y justifica con máximo tres párrafos.

Datos del aspirante:
Nombre: ${aspirante.nombre}
Edad: ${aspirante.edad}
Sexo: ${aspirante.sexo}

Cargo aspirado: ${cargo}

Resultados:
${factoresTexto}
`;

  try {
    const options = {
      model: process.env.OPENAI_MODEL || "gpt-5-nano",
      messages: [{ role: "user", content: prompt }],
    };

    const temp = process.env.OPENAI_TEMPERATURE || 0.7;
    if (!options.model.includes("nano")) {
      options.temperature = parseFloat(temp);
    }

    const response = await openai.chat.completions.create(options);

    return {
      texto: response.choices[0].message.content,
      modelo: response.model || options.model,
      tokens_entrada: response.usage?.prompt_tokens || 0,
      tokens_salida: response.usage?.completion_tokens || 0,
    };
  } catch (error) {
    logger.error("Error en llamada a OpenAI:", error.message);
    throw new Error("Error al generar interpretación IA con OpenAI");
  }
}

async function generarInterpretacionIA(aspirante, resultados, cargo) {
  if (process.env.IA_PROVIDER === "openai") {
    return await generarInterpretacionOpenAI(aspirante, resultados, cargo);
  }
  return await generarInterpretacionGroq(aspirante, resultados, cargo);
}

module.exports = { generarInterpretacionIA };
