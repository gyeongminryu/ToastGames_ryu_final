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