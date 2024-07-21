// Add active class to the current sidebar link
var links = document.querySelectorAll('.sidebar ul li a');
for (var i = 0; i < links.length; i++) {
    links[i].addEventListener('click', function() {
        var current = document.querySelector('.active');
        current.classList.remove('active');
        this.classList.add('active');
    });
}
