<div class='post-content post-type-<%- ctx.post.type %>'>
    <% if (['image', 'animation'].includes(ctx.post.type)) { %>

        <img class='resize-listener' alt='' src='<%- ctx.post.contentUrl %>'/>

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

        <% if (ctx.post.hasCustomThumbnail === true) { %>
            
            <img class='resize-listener' alt='' src='<%- ctx.post.thumbnailUrl %>'/>

        <% } else { %>

            <img class='resize-listener' alt='' src='/img/doc_zip.svg'/>

        <% } %>

    <% } else if (ctx.post.type === 'story') { %>

        <% if (ctx.post.mimeType === 'application/pdf') { %>

            <object class='resize-listener' data='<%- ctx.post.contentUrl %>'>
            </object>

        <% } else { %>

            <img class='resize-listener' alt='' src='/img/doc_story.svg'/>

        <% } %>

    <% } else { console.log(new Error('Unknown post type')); } %>

    <div class='post-overlay resize-listener'>
    </div>
</div>
