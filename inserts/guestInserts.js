const n = 101;
let users;

const generateCC = () => {
  let result = '';
  
  for (let index = 0; index < 16; index++) {
    const digit = Math.floor(Math.random() * 10);
    result += String(digit);
    if (index % 4 == 3 && index < 15) {
      result += ' ';
    }
  }

  return result;
}

const generatePoints = () => {
  const premium = Math.floor(Math.random() * 10); // 0-9

  if (premium < 8) {
    return -1;
  }
  
  return 100 * (Math.floor(Math.random() * 20) + 1);
}

const url = `https://randomuser.me/api/?nat=us&results=${n}`;

const res = fetch(url, {
  method: 'GET',
  headers: {
    'Content-Type' : 'application/json',
  },
}).then(res => res.json()).then(data => (data.results).forEach((e, i) => {
  console.log(`INSERT INTO guests (g_id, fname, lname, address, email, phone_number, cc_number, points) VALUES ('${String(i+1).padStart(5, '0')}', '${e.name.first}', '${e.name.last}', '${e.location.street.number} ${e.location.street.name}, ${e.location.city}, ${e.location.state} ${e.location.postcode}', '${e.email}', '${e.phone}', '${generateCC()}', ${generatePoints()});`);
}));

// document.getElementById('results').innerHTML = data.results;

