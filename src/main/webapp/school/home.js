// Initialize everything when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Typing Effect
    initTypingEffect();
    
    // Initialize Festival Popup with automatic date detection
    initFestivalPopup();
    
    // Initialize Navbar Scroll Effect
    initNavbarScroll();
    
    // Initialize Smooth Scrolling
    initSmoothScrolling();
    
    // Initialize Scroll Animations
    initScrollAnimations();
    
    // Initialize Contact Form
    initContactForm();
    
    // Initialize Gallery Modal
    initGalleryModal();
    
    // Initialize Back to Top Button
    initBackToTop();
    
    // Initialize Counter Animations
    initCounters();
    
    // Initialize Brochure Download
    initBrochureDownload();
});

// Typing Effect for Hero Title - Smaller font and no cursor
function initTypingEffect() {
    const typed = new Typed('#typed-title', {
        strings: ['Welcome to SAS', 'Empowering Minds', 'Shaping Future Leaders'],
        typeSpeed: 70,
        backSpeed: 50,
        backDelay: 2000,
        loop: true,
        showCursor: false, // Hide cursor as requested
        contentType: 'text',
        onStringTyped: function(arrayPos, self) {
            // Make text smaller
            self.el.style.fontSize = '1.6rem';
            self.el.style.fontWeight = '400';
        }
    });
}

// Festival Popup with Automatic Date Detection
function initFestivalPopup() {
    const festivals = [
        {
            title: "Merry Christmas & Happy New Year",
            bg: "https://img.freepik.com/free-vector/hand-drawn-flat-christmas-background_23-2149141098.jpg?semt=ais_hybrid&w=740&q=80",
            startMonth: 11, // December
            startDate: 20,
            endMonth: 0, // January
            endDate: 10
        },
        {
            title: "Happy Pongal & Makar Sankranti",
            bg: "https://c.ndtvimg.com/2020-01/b3ns635o_pongal-2020_625x300_11_January_20.jpg",
            startMonth: 0, // January
            startDate: 10,
            endMonth: 0,
            endDate: 20
        },
        {
            title: "Eid Mubarak",
            bg: "https://images.unsplash.com/photo-1603917814192-4c67ea8c8d53?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80",
            startMonth: 3, // April
            startDate: 10,
            endMonth: 3,
            endDate: 15
        },
        {
            title: "Happy Diwali",
            bg: "https://images.unsplash.com/photo-1604594849809-dfedbc827105?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80",
            startMonth: 9, // October
            startDate: 20,
            endMonth: 10, // November
            endDate: 10
        }
    ];

    const today = new Date();
    let currentFestival = festivals[0]; // Default to first festival
    
    // Find current festival based on date
    for (const festival of festivals) {
        const festivalStart = new Date(today.getFullYear(), festival.startMonth, festival.startDate);
        const festivalEnd = new Date(today.getFullYear(), festival.endMonth, festival.endDate);
        
        if (today >= festivalStart && today <= festivalEnd) {
            currentFestival = festival;
            break;
        }
    }
    
    // Update popup content
    document.getElementById('festivalTitle').textContent = currentFestival.title;
    document.getElementById('festivalBg').src = currentFestival.bg;
    
    // Show popup after 2 seconds
    setTimeout(() => {
        const modal = new bootstrap.Modal(document.getElementById('festivalModal'));
        modal.show();
    }, 2000);
}

// Navbar Scroll Effect
function initNavbarScroll() {
    const navbar = document.querySelector('.navbar-enhanced');
    
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
}

// Smooth Scrolling
function initSmoothScrolling() {
    document.querySelectorAll('nav a[href^="#"], .btn[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            
            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 80,
                    behavior: 'smooth'
                });
                
                // Close mobile menu if open
                const navbarCollapse = document.querySelector('.navbar-collapse.show');
                if (navbarCollapse) {
                    const bsCollapse = bootstrap.Collapse.getInstance(navbarCollapse);
                    if (bsCollapse) bsCollapse.hide();
                }
            }
        });
    });
}

// Scroll Animations
function initScrollAnimations() {
    // Add animation classes to all sections
    document.querySelectorAll('section').forEach(section => {
        section.classList.add('hidden');
    });
    
    // Handle scroll animations
    function handleScrollAnimation() {
        const elements = document.querySelectorAll('.hidden');
        
        elements.forEach(element => {
            if (isInViewport(element)) {
                element.classList.add('fade-in');
                
                // Animate child elements with delay
                const childElements = element.querySelectorAll('.card, .stat-card, .gallery-item');
                childElements.forEach((child, index) => {
                    setTimeout(() => {
                        child.classList.add('fade-in');
                    }, index * 100);
                });
            }
        });
        
        // Handle back to top button
        const backToTop = document.getElementById('backToTop');
        if (window.scrollY > 500) {
            backToTop.classList.add('active');
        } else {
            backToTop.classList.remove('active');
        }
    }
    
    // Check if element is in viewport
    function isInViewport(element) {
        const rect = element.getBoundingClientRect();
        return (
            rect.top <= (window.innerHeight || document.documentElement.clientHeight) * 0.85 &&
            rect.bottom >= 0
        );
    }
    
    // Initial check
    handleScrollAnimation();
    
    // Add scroll event listener
    window.addEventListener('scroll', handleScrollAnimation);
    
    // Check again after 300ms for elements already in view
    setTimeout(handleScrollAnimation, 300);
}

// Contact Form
function initContactForm() {
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Get form data
            const formData = new FormData(this);
            const name = formData.get('name') || 'User';
            
            // Show success message
            showNotification('Thank you for your message! We\'ll get back to you soon.', 'success');
            
            // Reset form
            this.reset();
        });
    }
}

// Gallery Modal
function initGalleryModal() {
    window.openModal = function(src) {
        document.getElementById('modalImage').src = src;
        new bootstrap.Modal(document.getElementById('imageModal')).show();
    }
}

// Back to Top Button
function initBackToTop() {
    const backToTopBtn = document.getElementById('backToTop');
    if (backToTopBtn) {
        backToTopBtn.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }
}

// Counter Animations
function initCounters() {
    const counters = document.querySelectorAll('.stat-card h3');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const counter = entry.target;
                const target = parseInt(counter.textContent.replace('+', ''));
                animateCounter(counter, target);
                observer.unobserve(counter);
            }
        });
    }, { threshold: 0.5 });
    
    counters.forEach(counter => observer.observe(counter));
}

function animateCounter(element, target) {
    let current = 0;
    const increment = target / 50;
    const duration = 1500;
    const stepTime = duration / 50;
    
    const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
            element.textContent = target + '+';
            clearInterval(timer);
        } else {
            element.textContent = Math.floor(current) + '+';
        }
    }, stepTime);
}

// Brochure Download
function initBrochureDownload() {
    window.downloadBrochure = function() {
        // Create a dummy PDF content
        const brochureContent = `
            SAS School Brochure 2025-26
            
            Welcome to SAS School
            Empowering Minds for a Brighter Tomorrow
            
            About Us:
            - Established: 1995
            - Curriculum: CBSE
            - Grades: KG to XII
            - Student Strength: 1500+
            - Faculty: 100+ Expert Teachers
            
            Facilities:
            - State-of-the-art Classrooms
            - Science & Computer Labs
            - Library with 10,000+ Books
            - Sports Complex
            - Auditorium
            
            Contact Information:
            Address: 123 Education Avenue, Learning City
            Phone: +91 123 456 7890
            Email: info@sasschool.edu
            Website: www.sasschool.edu
            
            Admissions Open for 2026-27
        `;
        
        // Create blob and download link
        const blob = new Blob([brochureContent], { type: 'application/pdf' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'SAS-School-Brochure-2025.pdf';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
        
        // Show notification
        showNotification('Brochure download started!', 'success');
    }
}

// Notification System
function showNotification(message, type = 'info') {
    // Remove existing notifications
    document.querySelectorAll('.notification').forEach(n => n.remove());
    
    // Create notification
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.innerHTML = `
        <i class="fas fa-${type === 'success' ? 'check-circle' : 'info-circle'} me-2"></i>
        ${message}
    `;
    
    document.body.appendChild(notification);
    
    // Show with animation
    setTimeout(() => notification.classList.add('show'), 10);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => notification.remove(), 300);
    }, 5000);
}

// Handle window resize for responsive adjustments
window.addEventListener('resize', function() {
    // Recalculate any responsive elements if needed
    const navbar = document.querySelector('.navbar-enhanced');
    if (window.innerWidth >= 768 && navbar) {
        navbar.classList.remove('scrolled');
    }
});

// Handle page load completion
window.addEventListener('load', function() {
    // Add loaded class for any post-load animations
    document.body.classList.add('loaded');
    
    // Trigger scroll animation check
    setTimeout(() => {
        const event = new Event('scroll');
        window.dispatchEvent(event);
    }, 500);
});


// Initialize Team Popup
function initTeamPopup() {
    // Handle clicks on "Our Team" from About dropdown
    document.querySelectorAll('.dropdown-item[href="#team"]').forEach(item => {
        item.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Close the dropdown menu first
            const dropdownMenu = this.closest('.dropdown-menu');
            if (dropdownMenu) {
                const dropdown = dropdownMenu.closest('.dropdown');
                if (dropdown) {
                    const dropdownToggle = dropdown.querySelector('.dropdown-toggle');
                    if (dropdownToggle) {
                        // Hide the dropdown using Bootstrap
                        const dropdownInstance = bootstrap.Dropdown.getInstance(dropdownToggle);
                        if (dropdownInstance) {
                            dropdownInstance.hide();
                        }
                    }
                }
            }
            
            // Show team modal after a small delay
            setTimeout(() => {
                const modalElement = document.getElementById('teamModal');
                if (modalElement) {
                    const modal = new bootstrap.Modal(modalElement);
                    modal.show();
                }
            }, 300);
        });
    });
    
    // Initialize close button for team modal
    const teamModalElement = document.getElementById('teamModal');
    if (teamModalElement) {
        // Handle Bootstrap close events
        teamModalElement.addEventListener('hide.bs.modal', function() {
            // Clean up any active animations
            const cards = teamModalElement.querySelectorAll('.team-card, .faculty-card');
            cards.forEach(card => {
                card.style.transition = '';
                card.style.opacity = '';
                card.style.transform = '';
            });
        });
        
        // Add custom close button handler
        const closeBtn = teamModalElement.querySelector('.btn-close');
        if (closeBtn) {
            closeBtn.addEventListener('click', function() {
                const modal = bootstrap.Modal.getInstance(teamModalElement);
                if (modal) {
                    modal.hide();
                }
            });
        }
        
        // Handle backdrop clicks
        teamModalElement.addEventListener('click', function(e) {
            if (e.target === this && this.classList.contains('show')) {
                const modal = bootstrap.Modal.getInstance(this);
                if (modal) {
                    modal.hide();
                }
            }
        });
        
        // Add animation when modal opens
        teamModalElement.addEventListener('shown.bs.modal', function() {
            animateTeamCards();
        });
    }
}

// Animate team cards in sequence
function animateTeamCards() {
    const modalElement = document.getElementById('teamModal');
    if (!modalElement) return;
    
    const leadershipCards = modalElement.querySelectorAll('.leadership-card');
    const facultyCards = modalElement.querySelectorAll('.faculty-card');
    
    // Reset animations
    [...leadershipCards, ...facultyCards].forEach(card => {
        card.style.opacity = '0';
        card.style.transition = 'none';
    });
    
    // Force reflow
    modalElement.offsetHeight;
    
    // Animate leadership cards
    leadershipCards.forEach((card, index) => {
        card.style.transform = 'translateY(20px)';
        
        setTimeout(() => {
            card.style.transition = 'all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94)';
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, index * 200 + 100);
    });
    
    // Animate faculty cards after leadership cards
    setTimeout(() => {
        facultyCards.forEach((card, index) => {
            card.style.transform = 'translateX(-20px)';
            
            setTimeout(() => {
                card.style.transition = 'all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94)';
                card.style.opacity = '1';
                card.style.transform = 'translateX(0)';
            }, index * 50 + 100);
        });
    }, leadershipCards.length * 200 + 300);
}

// Call initTeamPopup when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initTeamPopup);
} else {
    initTeamPopup();
}

// Also ensure modal close works with Escape key
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        const modalElement = document.getElementById('teamModal');
        if (modalElement && modalElement.classList.contains('show')) {
            const modal = bootstrap.Modal.getInstance(modalElement);
            if (modal) {
                modal.hide();
            }
        }
    }
});