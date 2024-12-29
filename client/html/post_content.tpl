<div class='post-content post-type-<%- ctx.post.type %>'>
    <% if (['image', 'animation'].includes(ctx.post.type)) { %>

        <% if (ctx.post.mimeType === 'image/vnd.adobe.photoshop') { %>
            <img class='resize-listener' alt='' src='<%- ctx.post.thumbnailUrl %>'/>
        <% } else { %>
            <img class='resize-listener' alt='' src='<%- ctx.post.contentUrl %>'/>
        <% } %>

    <% } else if (ctx.post.type === 'flash') { %>

        <object class='resize-listener' width='<%- ctx.post.canvasWidth %>' height='<%- ctx.post.canvasHeight %>' data='<%- ctx.post.contentUrl %>'>
            <param name='wmode' value='opaque'/>
            <param name='movie' value='<%- ctx.post.contentUrl %>'/>
        </object>

    <% } else if (ctx.post.type === 'video') { %>

        <%= ctx.makeElement(
            'video', {
                class: 'resize-listener',
                controls: true,
                loop: (ctx.post.flags || []).includes('loop'),
                playsinline: true,
                autoplay: ctx.autoplay,
            },
            ctx.makeElement('source', {
                type: ctx.post.mimeType,
                src: ctx.post.contentUrl,
            }),
            'Your browser doesn\'t support HTML5 videos.')
        %>

    <% } else if (ctx.post.type === 'zip') { %>

        <% if (ctx.post.mimeType === 'application/x-tgs') { %>

            <tgs-player autoplay loop mode='normal' src='<%- ctx.post.contentUrl %>'>
            </tgs-player>

        <% } else if (ctx.post.hasCustomThumbnail === true) { %>
            
            <img class='resize-listener' alt='' src='<%- ctx.post.thumbnailUrl %>'/>

        <% } else { %>

            <img class='resize-listener' alt='' src='/img/doc_zip.svg'/>

        <% } %>

    <% } else if (ctx.post.type === 'story') { %>

        <% if (ctx.post.mimeType === 'application/pdf') { %>

            <object class='resize-listener' data='<%- ctx.post.contentUrl %>'>
            <a href='<%- ctx.post.contentUrl %>'>No pdf embed support?</a>
            </object>

        <% } else if (ctx.post.mimeType === 'text/plain') { %>

            <object class='resize-listener' data='<%- ctx.post.contentUrl %>' type="text/plain">
            <a href='<%- ctx.post.contentUrl %>'>No plaintext embed support?</a>
            </object>


        <% } else { %>

            <img class='resize-listener' alt='' src='/img/doc_story.svg'/>

        <% } %>

    <% } else { console.log(new Error('Unknown post type')); } %>

    <div class='post-overlay resize-listener'>
    </div>
</div>
