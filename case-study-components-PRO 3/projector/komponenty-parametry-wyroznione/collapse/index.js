/** ProjectorCollapse */
app_shop.run(function () {
    ProjectorCollapse({
      parentSelector: '.--collapse-wrapper',
      parent: document.querySelector('#projector_collapse')
    })
  
    const onInsertCollapse = () => {
      const wrapper = document.querySelector('#projector_longdescription') ? document.querySelector('#projector_longdescription') : document.querySelector('#projector_form');
      const collapse = document.querySelector('#projector_collapse');
      
      if (wrapper) {
        wrapper.parentNode.insertBefore(collapse, wrapper.nextSibling);
        collapse.style.display = 'block';
        return true;
      }
    }
    
    const collapse = onInsertCollapse();
    if(collapse) {
      setTimeout(function() {
        document.querySelector('#projector_collapse').classList.remove('--skeleton');
      }, 500);
    }
}, 'all', '#projector_collapse')

app_shop.run(function ShowAllTraits() {
    const showAllTraitsElement = document.querySelector('.traits__all');
    showAllTraitsElement.addEventListener('click', function ShowAllTraitsClick(e) {
        e.preventDefault();
        document.querySelector('.traits').classList.add('--show');
        app_shop?.vars?.bLazy?.revalidate();
        return false;
    });
}, 'all', '.traits__all', true);
//