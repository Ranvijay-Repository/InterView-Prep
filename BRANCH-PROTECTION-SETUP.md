# Branch Protection Setup Guide

This guide will help you set up branch protection rules for your repository to ensure that:
- ✅ Only PRs can merge to the production branch
- ✅ Direct pushes to production are blocked
- ✅ All checks must pass before merging
- ✅ Automatic deployment only happens from production branch

## 🛡️ Setting Up Branch Protection Rules

### Step 1: Navigate to Repository Settings

1. Go to your GitHub repository
2. Click on **Settings** tab
3. In the left sidebar, click on **Branches**

### Step 2: Add Branch Protection Rule

1. Click **Add rule** button
2. In the **Branch name pattern** field, enter: `production`
3. Configure the following settings:

#### ✅ Required Settings

**Require a pull request before merging:**
- ✅ Check this box
- ✅ Require approvals: `1` (or more as needed)
- ✅ Dismiss stale PR approvals when new commits are pushed
- ✅ Require review from code owners (if you have a CODEOWNERS file)

**Require status checks to pass before merging:**
- ✅ Check this box
- ✅ Require branches to be up to date before merging
- In the search box, add these required status checks:
  - `build` (from deploy.yml)
  - `lint` (from lint.yml)

**Require conversation resolution before merging:**
- ✅ Check this box

**Require signed commits:**
- ✅ Check this box (recommended for security)

**Require linear history:**
- ✅ Check this box (keeps git history clean)

**Require deployments to succeed before merging:**
- ✅ Check this box

#### ⚠️ Important Settings

**Restrict pushes that create files:**
- ✅ Check this box

**Allow force pushes:**
- ❌ **DO NOT** check this box

**Allow deletions:**
- ❌ **DO NOT** check this box

### Step 3: Additional Security Settings

**Restrict pushes that create files:**
- ✅ Check this box

**Allow force pushes:**
- ❌ **DO NOT** check this box

**Allow deletions:**
- ❌ **DO NOT** check this box

### Step 4: Save the Rule

1. Click **Create** button
2. Verify the rule is active

## 🔧 GitHub Actions Settings

### Step 1: Enable GitHub Pages

1. Go to **Settings** → **Pages**
2. Under **Source**, select **GitHub Actions**
3. This enables the deployment workflow

### Step 2: Configure Actions Permissions

1. Go to **Settings** → **Actions** → **General**
2. Under **Workflow permissions**, select:
   - ✅ **Read and write permissions**
   - ✅ **Allow GitHub Actions to create and approve pull requests**

## 📋 Workflow Summary

### What Happens When You Merge PR to Production:

1. **Trigger**: Only when a PR is merged to `production` branch (not direct pushes)
2. **Verification**: Workflow verifies the commit is a PR merge commit
3. **Build**: Jekyll site is built with production settings
4. **Deploy**: Site is automatically deployed to GitHub Pages
5. **URL**: Your site will be available at `https://yourusername.github.io/your-repo-name`

### What Happens on Direct Push to Production:

1. **Blocked**: Direct pushes to production are blocked by branch protection
2. **No Deployment**: Even if somehow pushed, deployment won't trigger (not a PR merge)
3. **Security**: Ensures all changes go through proper review process

### What Happens on PR to Production:

1. **Lint**: Code quality and Jekyll validation checks
2. **Test Build**: Dry run build to catch errors early
3. **Comment**: PR gets a comment with build status
4. **Block Merge**: If checks fail, merge is blocked

## 🚀 Development Workflow

### Recommended Git Workflow:

```bash
# 1. Create a feature branch from main/master
git checkout main
git pull origin main
git checkout -b feature/your-feature-name

# 2. Make your changes
# ... edit files ...

# 3. Commit and push
git add .
git commit -m "Add your feature"
git push origin feature/your-feature-name

# 4. Create Pull Request
# Go to GitHub and create PR: feature/your-feature-name → production

# 5. After PR is approved and merged
# The site will automatically deploy!
```

## 🔍 Monitoring Deployments

### Check Deployment Status:

1. Go to **Actions** tab in your repository
2. Look for **Deploy to GitHub Pages** workflow
3. Green checkmark = successful deployment
4. Red X = deployment failed (check logs)

### View Your Live Site:

- **URL**: `https://yourusername.github.io/your-repo-name`
- **Custom Domain**: You can add a custom domain in Settings → Pages

## 🛠️ Troubleshooting

### Common Issues:

**"Workflow not triggering":**
- Ensure you're pushing to the `production` branch
- Check that the workflow file is in `.github/workflows/`

**"Build failing":**
- Check the Actions tab for error logs
- Ensure all Jekyll dependencies are in Gemfile
- Verify `_config.yml` syntax

**"Can't push to production":**
- This is expected! Use PRs instead
- Create a feature branch and submit a PR

**"Deployment not working":**
- Check GitHub Pages settings
- Ensure Actions permissions are enabled
- Verify the workflow has the correct permissions

## 📝 Additional Recommendations

### 1. Create a CODEOWNERS file:

Create `.github/CODEOWNERS`:
```
# Global owners
* @yourusername

# Documentation
*.md @yourusername

# Jekyll config
_config.yml @yourusername
Gemfile @yourusername
```

### 2. Set up branch naming conventions:

Consider using these branch patterns:
- `feature/description` - New features
- `fix/description` - Bug fixes
- `docs/description` - Documentation updates
- `chore/description` - Maintenance tasks

### 3. Enable branch protection for main/master too:

Apply similar protection rules to your main development branch to prevent direct pushes there as well.

## ✅ Verification Checklist

After setup, verify these work:

- [ ] Can't push directly to production branch
- [ ] PR to production triggers lint workflow
- [ ] PR merge to production triggers deployment
- [ ] Site deploys successfully to GitHub Pages
- [ ] Failed checks block PR merge
- [ ] All required status checks are configured

---

**🎉 Congratulations!** Your repository now has a robust CI/CD pipeline with proper branch protection!
