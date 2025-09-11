const a = 12, b = 7;

if (a > b) {
    console.log("a lebih besar dari b");
}

if (a < b) {
    console.log("a lebih kecil dari b");
} else {
    console.log("a tidak lebih kecil dari b");
}

if(a > b){
    console.log("a lebih besar dari b");
    console.log("a = " + a);
}

if(a > b){
    console.log("a lebih besar dari b");
} else if(a < b){
    console.log("a lebih kecil dari b");
} else {
    console.log("a sama dengan b");
}

const country = "Indonesia";
if(country == "Indonesia"){
    console.log("Halo, apa kabar?");
}
if(country != "Indonesia"){
    console.log("Hello, how are you?");
}
const greater = (a > b) ? a : b;
console.log("Nilai terbesar adalah " + greater);