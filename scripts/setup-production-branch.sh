#!/bin/bash

# Setup Production Branch Script
# This script helps set up the production branch for CI/CD deployment

set -e

echo "🚀 Setting up production branch for CI/CD deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    print_error "Not in a git repository. Please run this script from your project root."
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
print_status "Current branch: $CURRENT_BRANCH"

# Check if production branch already exists
if git show-ref --verify --quiet refs/heads/production; then
    print_warning "Production branch already exists."
    read -p "Do you want to update it with current changes? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Updating production branch..."
        git checkout production
        git merge "$CURRENT_BRANCH" --no-ff -m "Merge $CURRENT_BRANCH into production"
    else
        print_status "Skipping production branch update."
    fi
else
    print_status "Creating production branch from $CURRENT_BRANCH..."
    git checkout -b production
    print_success "Production branch created successfully!"
fi

# Ensure we're on production branch
git checkout production

# Check if remote origin exists
if ! git remote get-url origin > /dev/null 2>&1; then
    print_error "No remote origin found. Please add your GitHub repository as origin:"
    print_error "git remote add origin https://github.com/yourusername/your-repo.git"
    exit 1
fi

# Push production branch to remote
print_status "Pushing production branch to remote..."
if git push -u origin production; then
    print_success "Production branch pushed to remote successfully!"
else
    print_error "Failed to push production branch. Please check your remote configuration."
    exit 1
fi

# Switch back to original branch
git checkout "$CURRENT_BRANCH"
print_status "Switched back to $CURRENT_BRANCH"

# Display next steps
echo
print_success "🎉 Production branch setup complete!"
echo
echo "📋 Next steps:"
echo "1. Go to your GitHub repository settings"
echo "2. Navigate to Settings → Branches"
echo "3. Add branch protection rule for 'production' branch"
echo "4. Follow the instructions in BRANCH-PROTECTION-SETUP.md"
echo
echo "🔧 Branch protection settings to enable:"
echo "   ✅ Require a pull request before merging"
echo "   ✅ Require status checks to pass before merging"
echo "   ✅ Require conversation resolution before merging"
echo "   ✅ Require signed commits"
echo "   ✅ Require linear history"
echo "   ❌ Do NOT allow force pushes"
echo "   ❌ Do NOT allow deletions"
echo
echo "🚀 Your CI/CD pipeline will:"
echo "   • Run linting on all PRs to production"
echo "   • Deploy automatically when PRs are merged to production"
echo "   • Block direct pushes to production branch"
echo
print_warning "Remember: You can only update production via Pull Requests!"

# Check if GitHub CLI is available for easier setup
if command -v gh &> /dev/null; then
    echo
    read -p "Do you want to set up branch protection rules using GitHub CLI? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Setting up branch protection rules..."
        
        # Create branch protection rule
        gh api repos/:owner/:repo/branches/production/protection \
            --method PUT \
            --field required_status_checks='{"strict":true,"contexts":["build","lint"]}' \
            --field enforce_admins=true \
            --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
            --field restrictions=null \
            --field allow_force_pushes=false \
            --field allow_deletions=false \
            --field required_conversation_resolution=true \
            --field require_linear_history=true \
            --field require_signed_commits=true
        
        print_success "Branch protection rules configured!"
    fi
fi

echo
print_success "Setup complete! 🎉"
