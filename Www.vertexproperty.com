<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Vertex Property Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
body{
font-family: Arial;
margin:0;
background:#f4f4f4;
}

header{
background:green;
color:white;
padding:15px;
text-align:center;
font-size:20px;
font-weight:bold;
}

.container{
padding:15px;
}

.card{
background:white;
padding:15px;
margin-bottom:15px;
border-radius:10px;
box-shadow:0 0 5px rgba(0,0,0,0.1);
}

input, textarea, select{
width:100%;
padding:10px;
margin-top:5px;
margin-bottom:10px;
border-radius:8px;
border:1px solid #ccc;
}

button{
background:green;
color:white;
padding:10px;
border:none;
width:100%;
border-radius:8px;
font-size:16px;
}

.listing img{
width:100%;
border-radius:10px;
margin-top:10px;
}

.small{
font-size:13px;
color:gray;
}
</style>
</head>

<body>

<header>
VERTEX PROPERTY AGENCY - ADMIN DASHBOARD
</header>

<div class="container">

<!-- UPLOAD FORM -->
<div class="card">
<h3>Add New House</h3>

<input type="text" id="title" placeholder="House Title (e.g 2 Bedroom in Ruaka)">

<textarea id="desc" placeholder="Description (location, price, features...)"></textarea>

<select id="type">
<option>Apartment</option>
<option>Bungalow</option>
<option>Studio</option>
<option>Mansion</option>
</select>

<input type="file" id="image" accept="image/*">

<button onclick="addHouse()">Upload House</button>
</div>

<!-- LISTINGS -->
<div id="listings"></div>

</div>

<script>

let houses = [];

function addHouse(){
let title = document.getElementById("title").value;
let desc = document.getElementById("desc").value;
let type = document.getElementById("type").value;
let imageFile = document.getElementById("image").files[0];

if(!title || !desc || !imageFile){
alert("Jaza all fields");
return;
}

let reader = new FileReader();

reader.onload = function(e){

let house = {
title,
desc,
type,
image: e.target.result
};

houses.push(house);
render();
clearForm();
}

reader.readAsDataURL(imageFile);
}

function render(){
let container = document.getElementById("listings");
container.innerHTML = "";

houses.forEach((h, i)=>{
container.innerHTML += `
<div class="card listing">
<h3>${h.title}</h3>
<p class="small">${h.type}</p>
<p>${h.desc}</p>
<img src="${h.image}">
</div>
`;
});
}

function clearForm(){
document.getElementById("title").value="";
document.getElementById("desc").value="";
document.getElementById("image").value="";
}

</script>

</body>
</html>
