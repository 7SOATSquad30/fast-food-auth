export const handler = async (event) => {
  const cpf = event.queryStringParameters
    ? event.queryStringParameters.cpf
    : event.cpf;

  // CPF validation
  if (!cpf || !isValidCPF(cpf)) {
    return {
      statusCode: 400,
      body: JSON.stringify({ message: "Invalid or missing CPF" }),
    };
  }

  // Search for customer data (simulated)
  const customerData = getCustomerByCPF(cpf);
  if (!customerData) {
    return {
      statusCode: 404,
      body: JSON.stringify({ message: "Customer not found" }),
    };
  }

  // Returns customer data
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "Customer found",
      data: customerData,
    }),
  };
};

// Function to validate CPF (simple, without formatting)
function isValidCPF(cpf) {
  if (typeof cpf !== "string") return false;
  cpf = cpf.replace(/[^\d]+/g, "");
  if (cpf.length !== 11 || /^(\d)\1+$/.test(cpf)) return false;

  let sum = 0,
    rest;

  for (let i = 1; i <= 9; i++)
    sum += parseInt(cpf.substring(i - 1, i), 10) * (11 - i);
  rest = (sum * 10) % 11;
  if (rest === 10 || rest === 11) rest = 0;
  if (rest !== parseInt(cpf.substring(9, 10), 10)) return false;

  sum = 0;
  for (let i = 1; i <= 10; i++)
    sum += parseInt(cpf.substring(i - 1, i), 10) * (12 - i);
  rest = (sum * 10) % 11;
  if (rest === 10 || rest === 11) rest = 0;
  if (rest !== parseInt(cpf.substring(10, 11), 10)) return false;

  return true;
}

// Simulated function to search for customer data by CPF
function getCustomerByCPF(cpf) {
  const mockDatabase = {
    17955984099: {
      name: "João Silva",
      email: "joao.silva@example.com",
      phone: "17955984099",
    },
    59417976052: {
      name: "Maria Oliveira",
      email: "maria.oliveira@example.com",
      phone: "59417976052",
    },
  };

  return mockDatabase[cpf] || null;
}
