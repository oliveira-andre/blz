$(document).on("turbolinks:load", function () {
    $('#drag-and-drop-zone').dmUploader({
        url: '/demo/java-script/upload',
        maxFileSize: 3000000, // 3 Megs max
        allowedTypes: 'image/*',
        extFilter: ['jpg', 'jpeg', 'png', 'gif'],
        // ...
        onNewFile: function (id, file) {
            //...
            if (typeof FileReader !== 'undefined') {
                var reader = new FileReader();
                var img = $('<img />');

                reader.onload = function (e) {
                    img.attr('src', e.target.result);
                }
                /* ToDo: do something with the img! */
                reader.readAsDataURL(file);
            }
        },
        onFileTypeError: function (file) {
            // ...
        },
        onFileTypeError: function (file) {
            // ...
        }
        // ...
    });
});
