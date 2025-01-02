// Counter =============================================================

// counter
class Counter {
    constructor(quill, options) {
        this.quill = quill;
        this.options = options;
        this.container = document.querySelector(options.container);
        quill.on(Quill.events.TEXT_CHANGE, this.update.bind(this));
    }

    calculate() {
        const text = this.quill.getText();
        return text.length-1;
    }

    update() {
        const length = this.calculate();
        let separator = '/';
        let max = this.options.maxLength;
        let label = '자';
        let useMax = this.options.useMaxLength;
        if (useMax) {
            this.container.innerText = `${length} ${separator} ${max}${label}`;
            if (length > max) {
                this.quill.history.undo();
                this.container.classList.add('font_caution');
            } else {
                this.container.classList.remove('font_caution');
            }
        } else {
            this.container.innerText = `${length} ${label}`;
        }

    }
}

Quill.register('modules/counter', Counter);



// Copier ==============================================================

// copier
class Copier {
    constructor(quill, options) {
        this.quill = quill;
        this.options = options;
        this.container = document.querySelector(options.container);
        quill.on(Quill.events.TEXT_CHANGE, this.update.bind(this));
    }

    update() {
        const content = this.quill.container.firstChild.innerHTML;
        this.container.value = content;
    }
}

Quill.register('modules/copier', Copier);



// Editor ==============================================================

// fix width
fixEditorWidth();

function fixEditorWidth() {
    let editorWidth = document.getElementById('module_quill_editor').offsetWidth;
    document.getElementById('module_quill_editor').firstElementChild.style.width = editorWidth + 'px';
}