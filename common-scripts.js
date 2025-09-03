// 🚀 Common Scripts for JavaScript Documentation
// This file provides all interactive functionality used across the documentation

(function() {
    'use strict';
    
    // ===== COPY CODE FUNCTIONALITY =====
    window.copyCode = function(button) {
        // Prevent multiple rapid clicks
        if (button.disabled) return;
        
        // Disable button and show loading state
        button.disabled = true;
        const originalText = button.textContent;
        const originalBackground = button.style.background;
        
        button.textContent = '⏳ Copying...';
        button.style.background = '#6c757d';
        button.style.cursor = 'not-allowed';
        
        const codeBlock = button.nextElementSibling;
        const code = codeBlock.textContent;
        
        navigator.clipboard.writeText(code).then(() => {
            // Success animation
            button.textContent = '✅ Copied!';
            button.style.background = '#28a745';
            
            // Add success message
            showCopyMessage('Code copied successfully! 🎉', 'success');
            
            // Reset button after delay
            setTimeout(() => {
                button.textContent = originalText;
                button.style.background = originalBackground;
                button.disabled = false;
                button.style.cursor = 'pointer';
            }, 3000);
            
        }).catch(err => {
            console.error('Failed to copy: ', err);
            
            // Error animation
            button.textContent = '❌ Failed';
            button.style.background = '#dc3545';
            
            // Add error message
            showCopyMessage('Failed to copy code. Please try again.', 'error');
            
            // Reset button after delay
            setTimeout(() => {
                button.textContent = originalText;
                button.style.background = originalBackground;
                button.disabled = false;
                button.style.cursor = 'pointer';
            }, 3000);
        });
    };
    
    // ===== SOLUTION TOGGLE FUNCTIONALITY =====
    window.toggleSolution = function(button) {
        const solution = button.nextElementSibling;
        const isHidden = solution.style.display === 'none' || !solution.style.display;
        
        if (isHidden) {
            solution.style.display = 'block';
            solution.classList.add('show');
            button.textContent = 'Hide Solution';
            button.classList.add('showing');
            
            // Add slide-down animation
            solution.style.opacity = '0';
            solution.style.transform = 'translateY(-10px)';
            solution.style.transition = 'all 0.3s ease';
            
            setTimeout(() => {
                solution.style.opacity = '1';
                solution.style.transform = 'translateY(0)';
            }, 10);
        } else {
            solution.style.display = 'none';
            solution.classList.remove('show');
            button.textContent = 'Show Solution';
            button.classList.remove('showing');
        }
    };
    
    // ===== COPY MESSAGE FUNCTION =====
    function showCopyMessage(message, type) {
        // Remove existing message if any
        const existingMessage = document.querySelector('.copy-message');
        if (existingMessage) {
            existingMessage.remove();
        }
        
        // Create message element
        const messageDiv = document.createElement('div');
        messageDiv.className = `copy-message copy-message-${type}`;
        messageDiv.textContent = message;
        
        // Style the message
        messageDiv.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 12px 20px;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            font-size: 14px;
            z-index: 10000;
            transform: translateX(100%);
            transition: transform 0.5s ease;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            max-width: 300px;
            word-wrap: break-word;
        `;
        
        // Set background color based on type
        if (type === 'success') {
            messageDiv.style.background = 'linear-gradient(135deg, #28a745, #20c997)';
        } else {
            messageDiv.style.background = 'linear-gradient(135deg, #dc3545, #e74c3c)';
        }
        
        // Add to page
        document.body.appendChild(messageDiv);
        
        // Animate in
        setTimeout(() => {
            messageDiv.style.transform = 'translateX(0)';
        }, 100);
        
        // Animate out and remove
        setTimeout(() => {
            messageDiv.style.transform = 'translateX(100%)';
            setTimeout(() => {
                if (messageDiv.parentNode) {
                    messageDiv.parentNode.removeChild(messageDiv);
                }
            }, 500);
        }, 3000);
    }
    
    // ===== INITIALIZATION FUNCTIONS =====
    function initializeCopyButtons() {
        const copyButtons = document.querySelectorAll('button[onclick*="copyCode"]');
        copyButtons.forEach(button => {
            button.addEventListener('mouseenter', function() {
                if (!this.disabled) {
                    this.style.transform = 'scale(1.05)';
                    this.style.transition = 'transform 0.2s ease';
                }
            });
            
            button.addEventListener('mouseleave', function() {
                if (!this.disabled) {
                    this.style.transform = 'scale(1)';
                }
            });
        });
    }
    
    function initializeSolutionButtons() {
        const solutionButtons = document.querySelectorAll('button[onclick*="toggleSolution"]');
        solutionButtons.forEach(button => {
            button.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.05)';
                this.style.transition = 'transform 0.2s ease';
            });
            
            button.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
            });
        });
    }
    
    // ===== DOM READY HANDLER =====
    function initializeAll() {
        initializeCopyButtons();
        initializeSolutionButtons();
    }
    
    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initializeAll);
    } else {
        initializeAll();
    }
    
    // ===== MUTATION OBSERVER FOR DYNAMIC CONTENT =====
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.addedNodes.length > 0) {
                initializeAll();
            }
        });
    });
    
    observer.observe(document.body, {
        childList: true,
        subtree: true
    });
    
})();
