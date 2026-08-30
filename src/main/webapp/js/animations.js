/* Heading Animations - PowerLift Gym */

document.addEventListener('DOMContentLoaded', function() {
    initHeadingAnimations();
});

function initHeadingAnimations() {
    const headings = document.querySelectorAll('.animate-heading');
    
    headings.forEach(heading => {
        const text = heading.innerText.trim();
        heading.innerHTML = '';
        
        [...text].forEach((char, index) => {
            const span = document.createElement('span');
            span.textContent = char;
            span.className = 'drop-letter';
            // Stagger delay: 0.06s per letter
            span.style.animationDelay = (index * 0.06) + 's';
            heading.appendChild(span);
        });
    });
}
