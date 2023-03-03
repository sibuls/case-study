/**
 * Nowy element collapse
 * @param {string} parentSelector - selector elementu rodzica, dla którego chcemy wywołać mechanizm
 * @param {node} parent - element rodzić, dla którego chcemy wywołać mechanizm
 * Dla prawidłowego działania OBOWIĄZKOWE jest zachowanie struktury HTML:
    <div class="--collapse-wrapper">
        <div class="--item">
            <a class="--link" />
            <ul class="--list" />
        </div>
    </div>
 * Przykład --------------------------------------------------
    ProjectorCollapse({
        parentSelector: '.--collapse-wrapper',
        parent: document.querySelector('#projector_collapse')
    })
 * ----------------------------------------------------------
*/
ProjectorCollapse = function ProjectorCollapseFunction (params) {
    const that = this;
    this.params = params || {};

    this.setHeightParentList = (props) => {
        const { classParentList, list, operator } = props;

        if (list.closest(`${classParentList}.--list`) && list !== list.closest(`${classParentList}.--list`)) {
            const parentList = list.closest(`${classParentList}.--list`);
            const heightList = parseInt(list.style.height);
    
            if (operator) {
                parentList.style.height = `${parentList.offsetHeight + heightList}px`;
                return true;
            }
    
            if (!operator) {
                parentList.style.height = `${parentList.offsetHeight - heightList}px`;
            }
        }
    }

    this.onToggle = (props) => {
        const {parentSelector, parent} = props;
        
        const classParentList = document.querySelector('#projector_collapse > .--item > .--list') ? `.${document.querySelector('#projector_collapse > .--item > .--list').classList[0]}` : '';
        const items = parent.querySelectorAll(`${parentSelector} > .--item:not(.--checked)`) ? parent.querySelectorAll(`${parentSelector} > .--item:not(.--checked)`) : null;
    
        items?.forEach((item) => {
            const link = item.querySelector(`${parentSelector} > .--item > .--link`);
            const list = item.querySelector(`${parentSelector} > .--item > .--list`);
            item.classList.add('--checked');
    
            if (!list.childElementCount) {
                link.classList.add('--not_expanded');
                link.removeAttribute('href');
            }
    
            link.addEventListener('click', (e) => {
                e.preventDefault();
                
                setTimeout(() => { //Dla zapobiegania dużej ilości klików 
                    if (list.childElementCount) {
                        const listSub = list.children[0];
                        if (list.classList.contains('--active')) {
                            that.setHeightParentList({classParentList, list, operator: false});
                            list.classList.remove('--active');
                            link.classList.remove('--active');
                            list.style.height = `0px`;
                            return true;
                        }
        
                        list.classList.add('--active');
                        link.classList.add('--active');
                        list.style.height = `${listSub.offsetHeight}px`;
                        that.setHeightParentList({classParentList, list, operator: true});
                    }
                }, 300)
            })
        })
    }

    this.init = () => {
        const { parentSelector, parent } = this.params;

        this.parentSelector = parentSelector | '';
        this.parent = parent | {}; 
        this.onToggle(this.params);
    }

    return this.init();
}