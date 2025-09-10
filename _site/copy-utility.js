// 📋 Reusable Copy Code Utility
// This file provides copy functionality for all code blocks across the JavaScript Core documentation

(function() {
    'use strict';
    
    // Global copy function
    window.copyCode = function(button) {
        // Prevent multiple rapid clicks
        if (button.disabled) return;
        
        // Disable button and show loading state
        button.disabled = true;
        const originalText = button.textContent;
        const originalBackground = button.style.background;
        const originalTransform = button.style.transform;
        
        button.textContent = '⏳ Copying...';
        button.style.background = '#6c757d';
        button.style.cursor = 'not-allowed';
        
        const codeBlock = button.nextElementSibling;
        const code = codeBlock.textContent;
        
        navigator.clipboard.writeText(code).then(() => {
            // Success animation
            button.textContent = '✅ Copied!';
            button.style.background = '#28a745';
            button.style.transform = 'scale(1.1)';
            button.style.transition = 'all 0.3s ease';
            
            // Add success message
            showCopyMessage('Code copied successfully! 🎉', 'success');
            
            // Reset button after delay
            setTimeout(() => {
                button.textContent = originalText;
                button.style.background = originalBackground;
                button.style.transform = originalTransform;
                button.disabled = false;
                button.style.cursor = 'pointer';
            }, 3000);
            
        }).catch(err => {
            console.error('Failed to copy: ', err);
            
            // Error animation
            button.textContent = '❌ Failed';
            button.style.background = '#dc3545';
            button.style.transform = 'scale(0.95)';
            button.style.transition = 'all 0.3s ease';
            
            // Add error message
            showCopyMessage('Failed to copy code. Please try again.', 'error');
            
            // Reset button after delay
            setTimeout(() => {
                button.textContent = originalText;
                button.style.background = originalBackground;
                button.style.transform = originalTransform;
                button.disabled = false;
                button.style.cursor = 'pointer';
            }, 3000);
        });
    };
    
    // Show copy message function
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
    
    // Add hover effects to copy buttons
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
    
    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initializeCopyButtons);
    } else {
        initializeCopyButtons();
    }
    
    // Also initialize for dynamically added content
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.addedNodes.length > 0) {
                initializeCopyButtons();
            }
        });
    });
    
    observer.observe(document.body, {
        childList: true,
        subtree: true
    });
    
})();

// Add CSS styles
(function() {
    const style = document.createElement('style');
    style.textContent = `
        /* Enhanced copy button styles */
        button[onclick*="copyCode"] {
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        button[onclick*="copyCode"]:hover:not(:disabled) {
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            transform: translateY(-2px);
        }
        
        button[onclick*="copyCode"]:active:not(:disabled) {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        /* Copy message animations */
        .copy-message {
            animation: slideInRight 0.5s ease;
        }
        
        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        .copy-message-success {
            border-left: 4px solid #20c997;
        }
        
        .copy-message-error {
            border-left: 4px solid #e74c3c;
        }
    `;
    
    document.head.appendChild(style);
})();
