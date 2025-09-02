// /js/session-watch.js
(function (w) {
  function getCookie(name) {
    const m = document.cookie.match('(?:^|; )' + name.replace(/([.$?*|{}()\[\]\/+^])/g, '\\$1') + '=([^;]*)');
    return m ? decodeURIComponent(m[1]) : null;
  }

  function parseJwt(token) {
    const base64Url = token.split('.')[1]; if (!base64Url) return null;
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const json = decodeURIComponent(atob(base64).split('').map(c =>
      '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2)).join(''));
    return JSON.parse(json);
  }

  // Devuelve el primer segmento del path "/RISSERVER"
  function contextPath() {
    const parts = window.location.pathname.split('/').filter(Boolean);
    return parts.length > 0 ? '/' + parts[0] : '';
  }

  // Construye URLs absolutas con el origin actual y el context-path
  function buildAbsUrl(pathRelativeToCtx) {
    const ctx = contextPath(); // e.g. "/RISSERVER"
    return window.location.origin + ctx + pathRelativeToCtx;
  }

  let expiryTimerId = null;
  let cfg = {
    // Dejamos valores por defecto relativos, pero abajo construiremos absolutos al usarlos
    logoutUrl: '/access/logout?tipoCierre=Inactividad',
    loginUrl:  '/login.html',
    cookieName: 'token',
    checkEveryMs: 300000  // Consultar cada 5 minutos que el Token sigue activo
  };

  function onTokenExpired() {

    // Construimos URLs absolutas (origin + context-path + ruta)
    const absLogout = buildAbsUrl(cfg.logoutUrl);
    const absLogin  = buildAbsUrl(cfg.loginUrl);

    fetch(absLogout, { method: 'POST', credentials: 'include' })
      .finally(() => {
        alert('Sesión caducada, redirigiendo a Login');
        document.cookie = cfg.cookieName + '=; Max-Age=0; Path=/; SameSite=Lax';
        sessionStorage.removeItem('token');

        // Redirección robusta (evita volver con "Atrás")
        console.log('Redirigiendo a:', absLogin);
        window.location.replace(absLogin);
      });
  }

  function schedule() {
    if (expiryTimerId) { clearTimeout(expiryTimerId); expiryTimerId = null; }
    const token = getCookie(cfg.cookieName);
    if (!token) return;
    const payload = parseJwt(token);
    if (!payload || !payload.exp) return;
    const delta = payload.exp * 1000 - Date.now();
    expiryTimerId = setTimeout(onTokenExpired, Math.max(delta, 0));
  }

  function init(options) {
    cfg = Object.assign({}, cfg, options || {});
    document.addEventListener('DOMContentLoaded', schedule);
    setInterval(schedule, cfg.checkEveryMs);
  }

  w.sessionWatcher = { init };
})(window);
