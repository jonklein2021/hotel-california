// very fucking confused here

for (let i = 0; i < 12; i++) {
    const numRooms = 10*(Math.floor(Math.random() * (13 - 8 + 1)) + 8); // numRooms is 80-130
    for (let j = 0; j < numRooms; j++) {
        console.log(`INSERT INTO contains (h_id, r_number, r_type, r_capacity) VALUES ('${String(i+1).padStart(3, '0')}', '${e.location.street.number} ${e.location.street.name} ${e.location.state} ${e.location.country} ${e.location.postcode}');`);
    }
}
