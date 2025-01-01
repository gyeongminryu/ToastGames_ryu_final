// Toolbar =============================================================

// common
const Inline = Quill.import('blots/inline');
const Block = Quill.import('blots/block');

const onClick = (selector, callback) => {
    document.querySelector(selector).addEventListener('click', callback);
};

// bold
class BoldBlot extends Inline {
    static blotName = 'bold';
    static tagName = 'strong';
}

Quill.register(BoldBlot);

onClick('#toolbar_btn_bold', () => {
    quill.format('bold', true);
});

// italic
class ItalicBlot extends Inline {
    static blotName = 'italic';
    static tagName = 'em';
}

Quill.register(ItalicBlot);

onClick('#toolbar_btn_italic', () => {
    quill.format('italic', true);
});

// strike through
class StrikeBlot extends Inline {
    static blotName = 'strikeThrough';
    static tagName = 'del';
}

Quill.register(StrikeBlot);

onClick('#toolbar_btn_strike', () => {
    quill.format('strikeThrough', true);
});

// underline
class UnderlineBlot extends Inline {
    static blotName = 'underline';
    static tagName = 'ins';
}

Quill.register(UnderlineBlot);

onClick('#toolbar_btn_underline', () => {
    quill.format('underline', true);
});

// super subscript
class SuperSubscriptBlot extends Inline {
    static blotName = 'superSubscript';
    static tagName = 'sup';
}

Quill.register(SuperSubscriptBlot);

onClick('#toolbar_btn_superscript', () => {
    quill.format('superSubscript', true);
});

// subscript
class SubscriptBlot extends Inline {
    static blotName = 'subscript';
    static tagName = 'sub';
}

Quill.register(SubscriptBlot);

onClick('#toolbar_btn_script', () => {
    quill.format('subscript', true);
});



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
        let label = this.options.unit;
        this.container.innerText = `${length} ${label}`;
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

// draw editor
const quill = new Quill('#module_quill_editor', {
    placeholder: '보고할 내용을 입력하세요',
    modules: {
        history: { delay: 2000, maxStack: 500, userOnly: true },
        counter: { container: '#module_quill_counter', unit: '자'},
        copier: { container: '#module_quill_copier'}
    },
});