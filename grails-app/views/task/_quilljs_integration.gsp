<!-- Include the Quill library -->
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>

<!-- Initialize Quill editor -->
<script>
    var quill = new Quill('#editor-container', {
        modules: {
            toolbar: [
                [{ size: [ 'small', false, 'large', 'huge' ]}],
                ['bold', 'italic'],
                ['link', 'blockquote', 'code-block', 'image'],
                [{ list: 'ordered' }, { list: 'bullet' }]
            ]
        },
        placeholder: 'Compose a task description...',
        theme: 'snow'
    });

    var form = document.querySelector('form');
    form.onsubmit = function() {
        var desc = document.querySelector('input[name=description]');
        // desc.value = JSON.stringify(quill.getContents()); // getting Delta format content
        // console.log("Submitted", $(form).serialize(), $(form).serializeArray());

        var descHtml = quill.root.innerHTML;  // getting html format content
        desc.value = descHtml;
        console.log("html content:", descHtml);

        // return false;  // abort real form submission
        return true;
    };
</script>