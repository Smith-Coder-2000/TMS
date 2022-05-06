feather.replace({ 'aria-hidden': 'true' })

function remove(){
  $("#dashboard").removeClass("active");
  $("#movie").removeClass("active");
  $("#add").removeClass("active");
  $("#remove").removeClass("active");
  $("#screen").removeClass("active");
  $("#allocate").removeClass("active");
  $("#deallocate").removeClass("active");
  $("#customers").removeClass("active");
}

dashboard=document.getElementById("dashboard").addEventListener("click", dash);
movie=document.getElementById("movie").addEventListener("click", movies);
addMovie=document.getElementById("add").addEventListener("click", add);
removeMovie=document.getElementById("remove").addEventListener("click", removes);
screen=document.getElementById("screen").addEventListener("click", screens);
allocate=document.getElementById("allocate").addEventListener("click", assign);
deallocate=document.getElementById("deallocate").addEventListener("click", de_allocate);
customers=document.getElementById("customers").addEventListener("click", customer);


function dash(){
  $("#title").html("Dashboard");
  remove();
  $("#dashboard").addClass("active");
}

function movies(){
  $("#title").html("Movies");
  remove();
  $("#movie").addClass("active");
}

function add(){
  $("#title").html("Add movies");
  remove();
  $("#add").addClass("active");
  addmovies();
 }

function removes(){
  $("#title").html("Remove Movies");
  remove();
  $("#remove").addClass("active");
}

function screens(){
  $("#title").html("Screens");
  remove();
  $("#screen").addClass("active");
}

function assign(){
  $("#title").html("Assign Screens");
  remove();
  $("#allocate").addClass("active");
}

function de_allocate(){
  $("#title").html("De-allocate Screens");
  remove();
  $("#deallocate").addClass("active");
}

function customer(){
  $("#title").html("Customers");
  remove();
  $("#customers").addClass("active");
}


view=document.getElementById("view")
const addmovies = async () => {
  try {
      const res = await fetch('http://localhost:3000/addMovie');
      const data = await res.text();
      var parser = new DOMParser();
      var doc = parser.parseFromString(data,"text/html");
      view.replaceChild(doc.documentElement, view.childNodes[0]);
  } catch (e) {
      console.log("SOMETHING WENT WRONG!!!", e)
  }
}
