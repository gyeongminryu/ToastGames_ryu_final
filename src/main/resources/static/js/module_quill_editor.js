// Toolbar =============================================================

// regist module
class Toolbar {
    constructor(quill, options) {
        this.quill = quill;
        this.options = options;
        this.container = document.querySelector(options.container);
        this.container.innerHTML = this.update();
    }

    update() {
        let html = '';
        html += '<button type="button" onclick="quill.format(\'bold\', true);" class="toolbar_btn_bold"><i class="bi bi-type-bold"></i></button>';
        html += '<button type="button" onclick="quill.format(\'italic\', true);" class="toolbar_btn_italic"><i class="bi bi-type-italic"></i></button>';
        html += '<button type="button" onclick="quill.format(\'strikeThrough\', true);" class="toolbar_btn_strike"><i class="bi bi-type-strikethrough"></i></button>';
        html += '<button type="button" onclick="quill.format(\'underline\', true);" class="toolbar_btn_underline"><i class="bi bi-type-underline"></i></button>';
        html += '<button type="button" onclick="quill.format(\'superSubscript\', true);" class="toolbar_btn_superscript"><i class="bi bi-superscript"></i></button>';
        html += '<button type="button" onclick="quill.format(\'subscript\', true);" class="toolbar_btn_script"><i class="bi bi-subscript"></i></button>';
        html += '<span class="toolbar_seperator">|</span>';
        html += '<button type="button" onclick="quill.format(\'header\', 1);" class="toolbar_btn_h1"><i class="bi bi-type-h1"></i></button>';
        html += '<button type="button" onclick="quill.format(\'header\', 2);" class="toolbar_btn_h2"><i class="bi bi-type-h2"></i></button>';
        html += '<span class="toolbar_seperator">|</span>';
        html += '<button type="button" onclick="quill.format(\'align\', \'left\');" class="toolbar_btn_left"><i class="bi bi-text-left"></i></button>';
        html += '<button type="button" onclick="quill.format(\'align\', \'center\');" class="toolbar_btn_center"><i class="bi bi-text-center"></i></button>';
        html += '<button type="button" onclick="quill.format(\'align\', \'right\');" class="toolbar_btn_right"><i class="bi bi-text-right"></i></button>';
        html += '<button type="button" onclick="quill.format(\'align\', \'justify\');" class="toolbar_btn_justify"><i class="bi bi-justify"></i></button>';
        html += '<span class="toolbar_seperator">|</span>';
        html += '<button type="button" onclick="insert_divider()" class="toolbar_btn_divider"><i class="bi bi-dash-lg"></i></button>';
        html += '<button type="button" onclick="insert_link()" class="toolbar_btn_link"><i class="bi bi-link-45deg"></i></button>';
        return html;
    }
}

Quill.register('modules/toolbar', Toolbar);

// import
const Inline = Quill.import('blots/inline');
const Block = Quill.import('blots/block');
const BlockEmbed = Quill.import('blots/block/embed');

// bold
class BoldBlot extends Inline {
    static blotName = 'bold';
    static tagName = 'strong';
}

Quill.register(BoldBlot);

// italic
class ItalicBlot extends Inline {
    static blotName = 'italic';
    static tagName = 'em';
}

Quill.register(ItalicBlot);

// strike through
class StrikeBlot extends Inline {
    static blotName = 'strikeThrough';
    static tagName = 'del';
}

Quill.register(StrikeBlot);

// underline
class UnderlineBlot extends Inline {
    static blotName = 'underline';
    static tagName = 'ins';
}

Quill.register(UnderlineBlot);

// super subscript
class SuperSubscriptBlot extends Inline {
    static blotName = 'superSubscript';
    static tagName = 'sup';
}

Quill.register(SuperSubscriptBlot);

// subscript
class SubscriptBlot extends Inline {
    static blotName = 'subscript';
    static tagName = 'sub';
}

Quill.register(SubscriptBlot);

// headline
class HeaderBlot extends Block {
    static blotName = 'header';
    static tagName = ['h1', 'h2'];
}

Quill.register(HeaderBlot);

// align
class Align extends Block {
    static blotName = 'align';
    static tagName = super.tagName;

    static create(align) {
        let node = super.create();
        node.setAttribute('align', align);
        return node;
    }

    static formats(node) {
        return node.getAttribute('align');
    };
}

Quill.register(Align);

// divider
class DividerBlot extends BlockEmbed {
    static blotName = 'divider';
    static tagName = 'hr';
}

Quill.register(DividerBlot);

function insert_divider() {
    const range = quill.getSelection(true);
    quill.insertText(range.index, '\n', Quill.sources.USER);
    quill.insertEmbed(range.index + 1, 'divider', true, Quill.sources.USER);
    quill.setSelection(range.index + 2, Quill.sources.SILENT);
};

// link
class LinkBlot extends Inline {
    static blotName = 'link';
    static tagName = 'a';

    static create(url) {
        let node = super.create();
        node.setAttribute('href', url);
        node.setAttribute('target', '_blank');
        return node;
    }

    static formats(node) {
        return node.getAttribute('href');
    }
}

Quill.register(LinkBlot);

function insert_link() {
    const value = prompt('Enter link URL');
    quill.format('link', value);
}



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
        return text.length - 1;
    }

    update() {
        const length = this.calculate();
        let separator = '/';
        let max = this.options.maxLength;
        let label = '자';
        let useMax = this.options.useMaxLength;
        if (useMax) {
            this.container.innerText = `${length} ${separator} ${max} ${label}`;
            if (length >= max) {
                this.quill.deleteText(max, length);   // 글자수 초과시 초과한 글자수 삭제
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
        const content = this.quill.getSemanticHTML();
        this.container.value = content;
    }
}

Quill.register('modules/copier', Copier);



// Editor ==============================================================

// set height
class SetHeight {
    constructor(quill, options) {
        this.quill = quill;
        this.options = options;
        this.container = document.querySelector(options.container);
        this.quill.container.style.height = this.options.height + 'px';
    }
}

Quill.register('modules/setHeight', SetHeight);