(function () {
    'use strict';

    function closest(el, sel) {
        while (el && el !== document) {
            if (el.matches && el.matches(sel)) return el;
            el = el.parentNode;
        }
        return null;
    }

    function initAccountMenus() {
        var roots = document.querySelectorAll('[data-nav-account]');
        if (!roots.length) return;

        roots.forEach(function (root) {
            var trigger = root.querySelector('[data-nav-account-trigger]');
            var menu = root.querySelector('[data-nav-account-menu]');
            if (!trigger || !menu) return;

            function setOpen(open) {
                root.classList.toggle('is-open', open);
                trigger.setAttribute('aria-expanded', open ? 'true' : 'false');
                if (open) {
                    menu.removeAttribute('hidden');
                } else {
                    menu.setAttribute('hidden', 'hidden');
                }
            }

            trigger.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                var open = !root.classList.contains('is-open');
                setOpen(open);
            });
        });

        document.addEventListener('click', function (e) {
            roots.forEach(function (root) {
                if (!root.classList.contains('is-open')) return;
                if (closest(e.target, '[data-nav-account]') === root) return;
                var trigger = root.querySelector('[data-nav-account-trigger]');
                var menu = root.querySelector('[data-nav-account-menu]');
                root.classList.remove('is-open');
                if (trigger) trigger.setAttribute('aria-expanded', 'false');
                if (menu) menu.setAttribute('hidden', 'hidden');
            });
        });

        document.addEventListener('keydown', function (e) {
            if (e.key !== 'Escape') return;
            roots.forEach(function (root) {
                if (!root.classList.contains('is-open')) return;
                var trigger = root.querySelector('[data-nav-account-trigger]');
                var menu = root.querySelector('[data-nav-account-menu]');
                root.classList.remove('is-open');
                if (trigger) trigger.setAttribute('aria-expanded', 'false');
                if (menu) menu.setAttribute('hidden', 'hidden');
            });
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initAccountMenus);
    } else {
        initAccountMenus();
    }
})();
