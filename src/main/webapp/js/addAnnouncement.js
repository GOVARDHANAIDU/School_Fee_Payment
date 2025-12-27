// script.js (Updated: Removed session scriptlets as they are now inline in JSP)
document.addEventListener("DOMContentLoaded", function () {
  const video = document.querySelector("#schoolCarousel video");
  const carousel = document.querySelector("#schoolCarousel");
  let firstLoopDone = false;

  if (video) {
    video.addEventListener("timeupdate", function () {
      if (!firstLoopDone && (video.currentTime / video.duration) > 0.95) {
        firstLoopDone = true;
        const bsCarousel = bootstrap.Carousel.getInstance(carousel);
        if (bsCarousel) bsCarousel.cycle();
      }
    });
  }

  // Navbar Scroll Effect
  window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar-enhanced');
    if (navbar && window.scrollY > 50) {
      navbar.classList.add('scrolled');
    } else if (navbar) {
      navbar.classList.remove('scrolled');
    }
  });

  // Stats Counter Animation
  function animateCounters() {
    const counters = document.querySelectorAll('.stat-number');
    if (counters.length === 0) return;

    const observerOptions = { threshold: 0.5 };
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          counters.forEach(counter => {
            const targetText = counter.textContent.replace('+', '');
            const target = parseInt(targetText) || 0;
            const increment = target / 100;
            let current = 0;
            const updateCounter = () => {
              if (current < target) {
                current += increment;
                counter.textContent = Math.floor(current) + '+';
                setTimeout(updateCounter, 20);
              } else {
                counter.textContent = targetText;
              }
            };
            updateCounter();
          });
          observer.unobserve(entry.target);
        }
      });
    }, observerOptions);

    const statsSection = document.querySelector('.bg-light');
    if (statsSection) observer.observe(statsSection);
  }

  animateCounters();
});

// Dropdown hover enhancement
document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll('.dropdown-toggle').forEach(toggle => {
    toggle.addEventListener('mouseenter', function() {
      const dropdown = this.nextElementSibling;
      if (dropdown) {
        dropdown.style.animation = 'slideDown 0.3s ease-out';
      }
    });
  });
});