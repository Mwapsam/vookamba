// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./js/scripts"
import "./js/aos"
import "./js/counter"
import "./js/custom"
import "chartkick/chart.js"
import * as bootstrap from "bootstrap"
window.bootstrap = bootstrap;

const elem = document.getElementById('product')
console.log(elem);
