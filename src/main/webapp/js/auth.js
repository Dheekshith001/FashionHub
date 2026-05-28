/**
 * FashionHub — Authentication (auth.jsp)
 * Sliding forms, showcase crossfade, soft particles, navbar search.
 */
(function () {
    'use strict';

    var reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var TRANSITION_MS = 720;

    function $(sel, root) {
        return (root || document).querySelector(sel);
    }

    function $all(sel, root) {
        return Array.prototype.slice.call((root || document).querySelectorAll(sel));
    }

    function setAuthMode(mode) {
        var card = $('#authCard');
        if (!card) return;

        var isReg = mode === 'register';
        var nextPane = isReg ? 'register' : 'login';

        if (card.dataset.activePane === nextPane) {
            return;
        }

        card.classList.add('auth-card--animating');

        window.requestAnimationFrame(function () {
            card.dataset.mode = isReg ? 'register' : 'login';
            card.dataset.activePane = nextPane;
            card.classList.toggle('auth-card--register', isReg);
        });

        window.setTimeout(function () {
            card.classList.remove('auth-card--animating');
        }, TRANSITION_MS);
    }

    function initAuthToggle() {
        $all('[data-auth-show]').forEach(function (el) {
            el.addEventListener('click', function (e) {
                e.preventDefault();
                setAuthMode(el.getAttribute('data-auth-show') || 'login');
            });
        });
    }

    function initRegisterAddress() {
        var regForm = $('#registerForm');
        if (!regForm) return;

        regForm.addEventListener('submit', function () {

            var city = $('#reg-city');
            var state = $('#reg-state');
            var pin = $('#reg-pincode');
            var addr = $('#reg-address');

            if (!addr || !city || !state || !pin) return;

            var parts = [city.value, state.value, pin.value]
                .map(function (s) {
                    return (s || '').trim();
                })
                .filter(Boolean);

            addr.value = parts.join(', ');
        });
    }



	
	
	
	
	
	
	
	
	
    function initHeaderReveal() {
        document.body.classList.add('loaded');

        var header = $('.main-header');
        var navLinks = $('.nav-links');

        if (header) header.classList.add('show');
        if (navLinks) navLinks.classList.add('show');
    }

    function initParticles() {

        var canvas = $('#auth-particle-canvas');

        if (!canvas || reduceMotion) return;

        var ctx = canvas.getContext('2d');

        if (!ctx) return;

        var particles = [];
        var warm = 'rgba(255, 140, 90, 0.35)';
        var cool = 'rgba(180, 195, 220, 0.18)';

        function resize() {
            canvas.width = Math.floor(window.innerWidth);
            canvas.height = Math.floor(window.innerHeight);
        }

        function spawn() {

            particles.length = 0;

            var n = Math.min(56, Math.floor(canvas.width / 12));

            for (var i = 0; i < n; i++) {

                particles.push({
                    x: Math.random() * canvas.width,
                    y: Math.random() * canvas.height,
                    r: Math.random() * 1.6 + 0.25,
                    vx: (Math.random() - 0.5) * 0.35,
                    vy: (Math.random() - 0.5) * 0.35,
                    c: Math.random() > 0.48 ? warm : cool,
                    tw: Math.random() * Math.PI * 2
                });
            }
        }

        function frame() {

            var w = canvas.width;
            var h = canvas.height;

            ctx.clearRect(0, 0, w, h);

            for (var i = 0; i < particles.length; i++) {

                var p = particles[i];

                p.x += p.vx;
                p.y += p.vy;
                p.tw += 0.012;

                if (p.x < 0) p.x = w;
                if (p.x > w) p.x = 0;
                if (p.y < 0) p.y = h;
                if (p.y > h) p.y = 0;

                ctx.beginPath();
                ctx.fillStyle = p.c;
                ctx.globalAlpha = 0.55 + Math.sin(p.tw) * 0.2;
                ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
                ctx.fill();
            }

            ctx.globalAlpha = 1;
            ctx.lineWidth = 0.35;

            for (var j = 0; j < particles.length; j++) {

                var a = particles[j];

                for (var k = j + 1; k < particles.length; k++) {

                    var b = particles[k];

                    var dx = a.x - b.x;
                    var dy = a.y - b.y;
                    var dist = Math.sqrt(dx * dx + dy * dy);

                    var maxDist = Math.min(w, h) * 0.09;

                    if (dist < maxDist) {

                        var alpha = (1 - dist / maxDist) * 0.12;

                        ctx.strokeStyle =
                            'rgba(255, 160, 120, ' + alpha + ')';

                        ctx.beginPath();
                        ctx.moveTo(a.x, a.y);
                        ctx.lineTo(b.x, b.y);
                        ctx.stroke();
                    }
                }
            }

            requestAnimationFrame(frame);
        }

        function onResize() {
            resize();
            spawn();
        }

        window.addEventListener('resize', onResize);

        onResize();
        frame();
    }

    function init() {

        initHeaderReveal();
        initAuthToggle();
        initRegisterAddress();
      //  initNavbarSearch();
        initParticles();

        var card = $('#authCard');

        if (
            card &&
            card.getAttribute('data-initial-auth-tab') === 'register'
        ) {
            setAuthMode('register');
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

})();