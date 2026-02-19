/**
 * Role-Based UI Controller - Complete with Student & Faculty Restrictions
 * Optimized and scalable
 */

document.addEventListener("DOMContentLoaded", function() {
    const role = window.userRole || "guest";
    console.log(`🎯 Role Controller Active - User: ${role}`);
    
    // Apply all role-based restrictions
    applyRoleBasedRestrictions(role);
    
    // Disable unauthorized links
    disableUnauthorizedLinks(role);
});

/**
 * Main function to apply role-based restrictions
 */
function applyRoleBasedRestrictions(role) {
    const roleUpper = role.toUpperCase();
    
    // Apply based on role
    switch(roleUpper) {
        case 'STUDENT':
            hideForStudent();
            updateStudentUI();
            break;
            
        case 'FACULTY':
            hideForFaculty();
            updateFacultyUI();
            break;
            
        case 'CHANNEL_ADMIN':
            hideForChannelAdmin();
            break;
            
        case 'ADMIN':
            // Admin sees everything
            break;
            
        default:
            console.warn(`Unknown role: ${role}`);
    }
    
    // Hide elements with hideFunction class based on data-roles
    hideElementsByRole(roleUpper);
    
    // Handle empty dropdowns
    handleEmptyDropdowns();
}

/**
 * HIDE FOR STUDENT - All items/URLs to hide
 */
function hideForStudent() {
    console.log("👨‍🎓 Applying student restrictions...");
    
    // 1. HIDE NAVIGATION ITEMS BY TEXT
    hideNavItemsByText([
        'Payments',
        'Send Notifications',
        'Signup'
    ]);
    
    // 2. HIDE SPECIFIC DROPDOWN ITEMS (inside dropdowns)
    hideDropdownItems([
        'Student Details',
        'Student Payment Info',
        'Create Student Details',
        'Create Class',
        'Create Bulk',
        'Update Student Details',
        'All Payment Details',
        'Payment By Admin',
        'All Payment Status',
        'Add Announcements'
    ]);
    
    // 3. HIDE SPECIFIC URLS
    hideElementsByHref([
        'studentdetails.jsp',
        'allStudents.jsp',
        'studentreg.jsp',
        'create-class.jsp',
        'bulkimporting.jsp',
        'newupdates.jsp',
        'allpayments.jsp',
        'apbme.jsp',
        'paymentdetails.jsp',
        'addAnnouncement.jsp',
        'fee-notifications.jsp',
        'createaccount.jsp',
        'admin/',           // All admin pages
        'faculty/'          // All faculty pages
    ]);
    
    // 4. HIDE SPECIFIC CARDS/LINKS ON HOMEPAGE
    hideHomepageElements([
        'a[href="faculty/faculty.jsp"]'
    ]);
    
    // 5. HIDE ROLES DROPDOWN (if still showing)
    hideRolesDropdown();
}

/**
 * HIDE FOR FACULTY - All items/URLs to hide
 */
function hideForFaculty() {
    console.log("👨‍🏫 Applying faculty restrictions...");
    
    // 1. HIDE NAVIGATION ITEMS BY TEXT
    hideNavItemsByText([
        'Payments',
        'Signup'
    ]);
    
    // 2. HIDE SPECIFIC DROPDOWN ITEMS
    hideDropdownItems([
        'All Payment Details',
        'Payment By Admin',
        'All Payment Status',
        'Add Announcements'
    ]);
    
    // 3. HIDE SPECIFIC URLS
    hideElementsByHref([
        'allpayments.jsp',
        'apbme.jsp',
        'paymentdetails.jsp',
        'addAnnouncement.jsp',
        'createaccount.jsp',
		'payment.jsp',
        'admin/'           // All admin pages
    ]);
    
    // 4. HIDE STUDENTS DROPDOWN ITEMS (if faculty shouldn't manage students)
    // Uncomment if faculty shouldn't see student management:
    // hideDropdownItems([
    //     'Student Details',
    //     'Student Payment Info',
    //     'Student Fee Payment',
    //     'Create Student Details',
    //     'Create Class',
    //     'Create Bulk',
    //     'Update Student Details'
    // ]);
    
    // 5. HIDE ROLES DROPDOWN
    hideRolesDropdown();
}

/**
 * HIDE FOR CHANNEL ADMIN
 */
function hideForChannelAdmin() {
    // Channel Admin can see almost everything
    // Only hide admin-only features
    hideElementsByHref([
        'admin/dashboard.jsp'  // Admin-only dashboard
    ]);
}

/**
 * UTILITY FUNCTIONS
 */

/**
 * Hide navigation items by their text content
 */
function hideNavItemsByText(itemTexts) {
    itemTexts.forEach(text => {
        // Find all nav links with matching text
        const navItems = document.querySelectorAll('.nav-link, .dropdown-toggle, .btn');
        
        navItems.forEach(item => {
            if (item.textContent.trim() === text) {
                const parent = item.closest('.nav-item, .dropdown, .d-flex');
                if (parent) {
                    parent.style.display = 'none';
                    console.log(`❌ Hidden: ${text}`);
                }
            }
        });
    });
}

/**
 * Hide specific items inside dropdown menus
 */
function hideDropdownItems(itemTexts) {
    itemTexts.forEach(text => {
        const dropdownItems = document.querySelectorAll('.dropdown-item');
        
        dropdownItems.forEach(item => {
            if (item.textContent.trim() === text) {
                item.style.display = 'none';
                item.classList.add('hidden-by-role');
                console.log(`❌ Hidden dropdown item: ${text}`);
            }
        });
    });
}

/**
 * Hide elements by their href attribute
 */
function hideElementsByHref(urlPatterns) {
    urlPatterns.forEach(pattern => {
        const selector = `a[href*="${pattern}"]`;
        const elements = document.querySelectorAll(selector);
        
        elements.forEach(element => {
            const parent = element.closest('.nav-item, .dropdown, .dropdown-item, .btn, .d-flex');
            if (parent) {
                parent.style.display = 'none';
                console.log(`❌ Hidden URL pattern: ${pattern}`);
            }
        });
    });
}

/**
 * Hide homepage elements by selector
 */
function hideHomepageElements(selectors) {
    selectors.forEach(selector => {
        const elements = document.querySelectorAll(selector);
        elements.forEach(element => {
            element.style.display = 'none';
            console.log(`❌ Hidden homepage element: ${selector}`);
        });
    });
}

/**
 * Hide roles dropdown completely
 */
function hideRolesDropdown() {
    const rolesDropdown = document.querySelector('.dropdown:has(button:contains("Roles")), .dropdown:has(button:contains("Switch"))');
    if (rolesDropdown) {
        rolesDropdown.style.display = 'none';
        console.log('❌ Hidden Roles dropdown');
    }
}

/**
 * Hide elements with hideFunction class based on data-roles attribute
 */
function hideElementsByRole(currentRole) {
    const hideFunctionElements = document.querySelectorAll('.hideFunction');
    
    hideFunctionElements.forEach(element => {
        const allowedRoles = element.getAttribute('data-roles');
        
        if (allowedRoles) {
            const rolesArray = allowedRoles.split(',').map(r => r.trim().toUpperCase());
            
            if (!rolesArray.includes(currentRole)) {
                element.style.display = 'none';
                element.classList.add('role-hidden');
                console.log(`❌ Hidden by data-roles: ${element.tagName}.${element.className}`);
            }
        }
    });
}

/**
 * Handle empty dropdowns after hiding items
 */
function handleEmptyDropdowns() {
    document.querySelectorAll('.dropdown-menu').forEach(menu => {
        const visibleItems = Array.from(menu.children)
            .filter(item => item.style.display !== 'none');
        
        if (visibleItems.length === 0) {
            const dropdownParent = menu.closest('.dropdown, .nav-item.dropdown');
            if (dropdownParent) {
                dropdownParent.style.display = 'none';
                console.log('❌ Hidden empty dropdown');
            }
        }
    });
}

/**
 * Update UI for student role
 */
function updateStudentUI() {
    // Update greeting with admission number
    const greeting = document.querySelector('.text-white.fw-semibold');
    if (greeting && window.userAdmissionNo) {
        const name = greeting.textContent.replace('Hello,', '').trim();
        greeting.textContent = `Student ${window.userAdmissionNo}, ${name}`;
    }
    
    // Change role badge color
    const roleBadge = document.querySelector('.role-badge');
    if (roleBadge) {
        roleBadge.className = 'badge bg-success role-badge';
        roleBadge.textContent = 'STUDENT';
    }
}

/**
 * Update UI for faculty role
 */
function updateFacultyUI() {
    // Update greeting
    const greeting = document.querySelector('.text-white.fw-semibold');
    if (greeting) {
        const name = greeting.textContent.replace('Hello,', '').trim();
        greeting.textContent = `Faculty, ${name}`;
    }
    
    // Change role badge color
    const roleBadge = document.querySelector('.role-badge');
    if (roleBadge) {
        roleBadge.className = 'badge bg-info role-badge';
        roleBadge.textContent = 'FACULTY';
    }
}

/**
 * Disable unauthorized links (prevent clicks)
 */
function disableUnauthorizedLinks(role) {
    const restrictedUrls = {
        'STUDENT': [
            'studentdetails.jsp',
            'allStudents.jsp',
            'studentreg.jsp',
            'create-class.jsp',
            'bulkimporting.jsp',
            'newupdates.jsp',
            'allpayments.jsp',
            'apbme.jsp',
            'paymentdetails.jsp',
            'addAnnouncement.jsp',
            'fee-notifications.jsp',
            'createaccount.jsp',
            'admin/',
            'faculty/'
        ],
        'FACULTY': [
            'allpayments.jsp',
            'apbme.jsp',
            'paymentdetails.jsp',
            'createaccount.jsp',
            'admin/'
        ]
    };
    
    const urls = restrictedUrls[role.toUpperCase()] || [];
    
    urls.forEach(url => {
        const links = document.querySelectorAll(`a[href*="${url}"]`);
        
        links.forEach(link => {
            // Prevent clicking
            link.addEventListener('click', function(e) {
                e.preventDefault();
                showAccessDeniedMessage(role);
            });
            
            // Visual indication
            link.style.opacity = '0.6';
            link.style.cursor = 'not-allowed';
            link.title = 'Not available for your role';
            link.classList.add('role-restricted');
        });
    });
}

/**
 * Show access denied message
 */
function showAccessDeniedMessage(role) {
    const messages = {
        'STUDENT': 'This feature is only available for administrators.',
        'FACULTY': 'This feature requires administrative privileges.',
        'default': 'You do not have permission to access this feature.'
    };
    
    alert(`⛔ Access Denied\n${messages[role.toUpperCase()] || messages.default}`);
}

/**
 * Check if user has permission (utility function)
 */
/**
 * Check if user has permission (utility function)
 */
function hasPermission(allowedRoles) {
    // Normalize current user role
    const currentRole = (window.userRole || 'GUEST').toString()
        .replace(/["']/g, '')  // Remove quotes
        .trim()
        .toUpperCase();

    // Debug log
    console.log(`Checking permission for role: ${currentRole}, allowed: ${allowedRoles}`);

    // If no restriction is defined → allow access
    if (!allowedRoles || allowedRoles === '*') {
        return true;
    }

    // Convert allowed roles to array safely
    const rolesArray = Array.isArray(allowedRoles)
        ? allowedRoles.map(r => r.toString().trim().toUpperCase())
        : allowedRoles
            .toString()
            .split(',')
            .map(r => r.trim().toUpperCase().replace(/["']/g, ''));

    // Check permission
    return rolesArray.includes(currentRole);
}

/**
 * Check if element should be visible for current role
 */
function isVisibleForRole(elementSelector) {
    const element = document.querySelector(elementSelector);
    return element && element.style.display !== 'none';
}

// Export for debugging and external use
window.RoleController = {
    applyRoleBasedRestrictions,
    hideForStudent,
    hideForFaculty,
    hasPermission,
    isVisibleForRole,
    getCurrentRole: () => window.userRole || 'guest',
    getAdmissionNo: () => window.userAdmissionNo || null
};

// CSS for role restrictions
const style = document.createElement('style');
style.textContent = `
    .role-hidden {
        display: none !important;
    }
    .role-restricted {
        opacity: 0.6 !important;
        cursor: not-allowed !important;
        pointer-events: none;
    }
    .hidden-by-role {
        display: none;
    }
    .role-badge {
        font-size: 0.75rem;
        padding: 0.25rem 0.5rem;
    }
`;
document.head.appendChild(style);

// Add this function to your existing roleControl.js
function optimizeHiddenElements() {
    // Make hidden elements truly collapse
    document.querySelectorAll('[style*="display: none"]').forEach(el => {
        // Remove from document flow completely
        el.style.position = 'absolute';
        el.style.width = '0';
        el.style.height = '0';
        el.style.padding = '0';
        el.style.margin = '0';
        el.style.overflow = 'hidden';
        el.style.visibility = 'hidden';
    });
    
    // Recalculate grid for cards
    const cardRow = document.querySelector('.container.my-4 .row');
    if (cardRow) {
        const visibleCards = Array.from(cardRow.children)
            .filter(card => card.style.display !== 'none');
        
        // Adjust card widths
        visibleCards.forEach((card, index) => {
            card.style.flex = visibleCards.length === 1 ? '0 0 100%' : 
                            visibleCards.length === 2 ? '0 0 48%' : '0 0 32%';
            card.style.maxWidth = visibleCards.length === 1 ? '100%' : 
                                visibleCards.length === 2 ? '48%' : '32%';
            card.style.marginRight = '2%';
            
            // Remove margin from last item
            if (index === visibleCards.length - 1) {
                card.style.marginRight = '0';
            }
        });
    }
}

// Call this function at the end of your DOMContentLoaded function:
// setTimeout(optimizeHiddenElements, 200);


console.log('✅ Role Controller loaded successfully');