$ ->
    $('#article-markdown-field').on 'keyup change paste', (e) ->
        $.ajax
            url: "/markdown_result"
            type: "GET"
            data: {description: e.target.value }
            error: (res) ->
                console.error(res)
            success: (res) ->
                $('#markdown-result').html(res)
