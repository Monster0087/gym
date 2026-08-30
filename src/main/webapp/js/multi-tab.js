(function() {
    // 1. Initialize Tab ID in sessionStorage (unique per tab)
    let tabId = sessionStorage.getItem('tabId');
    if (!tabId) {
        tabId = 'tab_' + Math.random().toString(36).substring(2, 9);
        sessionStorage.setItem('tabId', tabId);
    }

    // 2. Append Tab ID to all internal links
    function updateLinks() {
        document.querySelectorAll('a').forEach(link => {
            const href = link.getAttribute('href');
            if (href && !href.startsWith('http') && !href.startsWith('#') && !href.startsWith('javascript:')) {
                const url = new URL(href, window.location.href);
                url.searchParams.set('tabId', tabId);
                link.setAttribute('href', url.pathname + url.search + url.hash);
            }
        });
    }

    // 3. Add hidden input to all forms
    function updateForms() {
        document.querySelectorAll('form').forEach(form => {
            if (!form.querySelector('input[name="tabId"]')) {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'tabId';
                input.value = tabId;
                form.appendChild(input);
            }
        });
    }

    // 4. Intercept Fetch/XHR for AJAX isolation
    const originalFetch = window.fetch;
    window.fetch = function() {
        const args = Array.from(arguments);
        if (args[1] && args[1].headers) {
            args[1].headers['X-Tab-ID'] = tabId;
        } else if (args[1]) {
            args[1].headers = { 'X-Tab-ID': tabId };
        } else {
            args[0] = addParamToUrl(args[0], 'tabId', tabId);
        }
        return originalFetch.apply(this, args);
    };

    function addParamToUrl(url, key, value) {
        if (typeof url !== 'string') return url;
        const separator = url.indexOf('?') !== -1 ? '&' : '?';
        return url + separator + key + '=' + value;
    }

    // Initial run and watch for DOM changes
    updateLinks();
    updateForms();
    
    const observer = new MutationObserver(() => {
        updateLinks();
        updateForms();
    });
    observer.observe(document.body, { childList: true, subtree: true });

    // Handle initial redirect if tabId missing from URL but present in sessionStorage
    const urlParams = new URLSearchParams(window.location.search);
    if (!urlParams.has('tabId')) {
        urlParams.set('tabId', tabId);
        window.history.replaceState(null, '', window.location.pathname + '?' + urlParams.toString() + window.location.hash);
    }
})();
