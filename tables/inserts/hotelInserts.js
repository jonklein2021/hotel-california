const n = 12;
const url = `https://randomuser.me/api/?nat=us&results=${n}`;

const res = fetch(url, {
    method: 'GET',
    headers: {
        'Content-Type' : 'application/json',
},
}).then(res => res.json()).then(data => (data.results).forEach((e, i) => {
    console.log(`INSERT INTO hotels (h_id, address) VALUES ('${String(i+1).padStart(3, '0')}', '${e.location.street.number} ${e.location.street.name} ${e.location.state} ${e.location.country} ${e.location.postcode}');`);
}));