$(document).on("turbolinks:load", function () {
    $(document).ready(function() {
        $(function(){
            $('.delete-link').on('ajax:success', function() {
                $(this).parents('div:first').remove();
            });
        });
        if (window.File && window.FileList && window.FileReader) {
            $("#files").on("change", function(e) {
                var files = e.target.files,
                    filesLength = files.length;
                for (var i = 0; i < filesLength; i++) {
                    var f = files[i]
                    var fileReader = new FileReader();
                    fileReader.onload = (function(e) {
                        var file = e.target;
                        console.log(e)
                        $("<span class=\"pip\">" +
                            "<img  class=\"imageThumb\" src=\"" + e.target.result + "\" title=\"" + file.name + "\"/>" +
                            "<br/><span class=\"remove\">Remover foto</span>" +
                            "</span>").insertAfter("#files");
                        $(".remove").click(function(){
                            $(this).parent(".pip").remove();
                        });
                    });
                    fileReader.readAsDataURL(f);
                }
            });
        }
    });

});
