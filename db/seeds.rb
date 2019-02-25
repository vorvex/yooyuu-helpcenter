# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

orgtour = Tour.create(name: "Organizator Erste Schritte", description: "", image_url: "")

org1 = Step.create(step: 1, tour_id: 1, head: "YooYuu kennenlernen", body: "", type: "", video_url: "", image_url: "", est_time: 3);

org2 = Step.create(step: 2, tour_id: 1, head: "Aufbau der App", body: "", type: "", video_url: "", image_url: "", est_time: 3);

org3 = Step.create(step: 3, tour_id: 1, head: "Weitere Funktionen", body: "", type: "", video_url: "", image_url: "", est_time: 3);

org4 = Step.create(step: 4, tour_id: 1, head: "Orga-App & Web-App", body: "", type: "", video_url: "", image_url: "", est_time: 3);

org5 = Step.create(step: 5, tour_id: 1, head: "Kategorien & Gruppen", body: "", type: "", video_url: "", image_url: "", est_time: 3);

org6 = Step.create(step: 6, tour_id: 1, head: "Nutzer anlegen", body: "", type: "", video_url: "", image_url: "", est_time: 3);

org7 = Step.create(step: 7, tour_id: 1, head: "Handy verloren, etc.", body: "", type: "", video_url: "", image_url: "", est_time: 3);

# Angestellte Erste Schritte

# employeetour = Tour.create(name: "Angestellte Erste Schritte", description: "", image_url: "")

# employee1 = Step.create(step: 1, tour_id: orgtour, head: "", body: "", type: "", video_url: "", image_url: "", est_time: "");

# employee2 = Step.create(step: 2, tour_id: orgtour, head: "", body: "", type: "", video_url: "", image_url: "", est_time: "");

# employee3 = Step.create(step: 3, tour_id: orgtour, head: "", body: "", type: "", video_url: "", image_url: "", est_time: "");

# employee4 = Step.create(step: 4, tour_id: orgtour, head: "", body: "", type: "", video_url: "", image_url: "", est_time: "");

# employee5 = Step.create(step: 5, tour_id: orgtour, head: "", body: "", type: "", video_url: "", image_url: "", est_time: "");

# employee6 = Step.create(step: 6, tour_id: orgtour, head: "", body: "", type: "", video_url: "", image_url: "", est_time: "");

# employee7 = Step.create(step: 7, tour_id: orgtour, head: "", body: "", type: "", video_url: "", image_url: "", est_time: "");

