// Navbar Scroll Effect (Enhanced with transform)
window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar-enhanced');
    if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
        navbar.style.transform = 'translateY(-10px)'; // Subtle lift on scroll
    } else {
        navbar.classList.remove('scrolled');
        navbar.style.transform = 'translateY(0)';
    }
});

// Smooth Scrolling for Nav Links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Enhanced Dropdown Animation Trigger
document.querySelectorAll('.dropdown-toggle').forEach(toggle => {
    toggle.addEventListener('mouseenter', function() {
        const dropdown = this.nextElementSibling;
        dropdown.style.animation = 'slideDown 0.3s ease-out';
    });
});

// Gallery Modal
function openModal(src) {
    document.getElementById('modalImage').src = src;
}

// Contact Form Submission
document.getElementById('contactForm').addEventListener('submit', function(e) {
    e.preventDefault();
    // Simulate form submission (replace with actual AJAX if needed)
    alert('Thank you for your message! We\'ll get back to you soon.');
    this.reset();
});

// Counter Animation for Stats (on scroll)
function animateCounters() {
    const counters = document.querySelectorAll('.stat-card h3');
    counters.forEach(counter => {
        const target = parseInt(counter.textContent.replace('+', ''));
        const increment = target / 100;
        let current = 0;
        const updateCounter = () => {
            if (current < target) {
                current += increment;
                counter.textContent = Math.floor(current) + (target > 1000 ? 'k+' : '+');
                setTimeout(updateCounter, 20);
            } else {
                counter.textContent = target + '+';
            }
        };
        updateCounter();
    });
}

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            animateCounters();
            observer.unobserve(entry.target);
        }
    });
});

if (document.querySelector('.about')) {
    observer.observe(document.querySelector('.about'));
}

// Preloader (if needed, add a preloader div in HTML)
window.addEventListener('load', function() {
    // Trigger navbar load animation
    const navItems = document.querySelectorAll('.navbar-nav .nav-item');
    navItems.forEach((item, index) => {
        item.style.animationDelay = `${index * 0.1}s`;
    });
    // Hide preloader if present
});