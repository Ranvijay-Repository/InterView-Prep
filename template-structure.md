# 📋 Template Structure for Documentation Files

This template shows the proper structure to use for all documentation files to avoid duplication.

## 📁 File Structure

```
/Users/ranvijaychouhan/Desktop/Personal/Interview-prep/
├── common-styles.css          # All common styles
├── common-scripts.js          # All common JavaScript functionality
├── copy-utility.js            # Legacy copy utility (can be removed)
├── template-structure.md      # This template file
└── [Your Documentation Files] # All your .md files
```


## 🎨 How to Use Common Files

### 1. **CSS Integration**
Add this line at the top of your markdown file (after the title):

```html
<link rel="stylesheet" href="../common-styles.css">
```


### 2. **JavaScript Integration**
Add this line before the closing `</body>` tag:

```html
<script src="../common-scripts.js"></script>
```


## 📝 Standard File Structure


```markdown
# 🔹 Your Title Here

*Brief description*

---

## 📚 Table of Contents
- [Section 1](#section-1)
- [Section 2](#section-2)
- [Section 3](#section-3)

---

## 🎯 Section 1
Your content here...

### Code Example
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Your code here
console.log("Hello World");</code></pre>
</div>

---

## 🧪 Practice Exercises

<div class="practice-exercise">
    <h4>Exercise Title</h4>
    <p>Exercise description...</p>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <p>Solution explanation...</p>
        <div style="position: relative;">
        <button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
        <pre><code>// Solution code here</code></pre>
        </div>
    </div>
</div>

---

## ❓ Common Interview Questions

<div class="interview-question">
    <h4>Question Title</h4>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <p>Answer here...</p>
    </div>
</div>

---

## 🧭 Navigation

<div class="navigation">
    <a href="previous-file.md" class="nav-link prev">← Previous: Previous Topic</a>
    <a href="next-file.md" class="nav-link next">Next: Next Topic →</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

*Last updated: December 2024*
```


## 🔧 Key Benefits

1. **No Duplication**: All styles and scripts are in one place
2. **Easy Maintenance**: Update one file to change everything
3. **Consistent Look**: All files will have the same appearance
4. **Clean Code**: Each .md file focuses only on content
5. **Fast Loading**: CSS and JS are cached across files

## ⚠️ Important Notes

- Use `../` to go up one directory level from your current file
- Always include both CSS and JS files
- Use the exact class names from the common files
- The copy buttons and solution toggles will work automatically
- All animations and interactions are handled by the common scripts

## 🚀 Next Steps

1. Update your existing files to use this structure
2. Remove any duplicate CSS/JS from individual files
3. Test that all functionality works correctly
4. Enjoy the clean, maintainable codebase!
