// Auto-detect API base URL
// - localhost → http://localhost:5000
// - production → https://jsanger.42.fr/api
const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
  ? 'http://localhost:5000'
  : '/api';

const statusEl  = document.getElementById('api-status');
const apiUrlEl  = document.getElementById('api-url');
const listEl    = document.getElementById('entries-list');
const form      = document.getElementById('guestbook-form');
const errorEl   = document.getElementById('form-error');

apiUrlEl.textContent = API_BASE;

async function ping() {
  try {
    const res = await fetch(`${API_BASE}/ping`);
    if (res.ok) {
      statusEl.textContent = 'api online';
      statusEl.className = 'online';
    } else {
      throw new Error();
    }
  } catch {
    statusEl.textContent = 'api offline';
    statusEl.className = 'offline';
  }
}

async function loadEntries() {
  listEl.innerHTML = '<p class="loading">Loading entries...</p>';
  try {
    const res = await fetch(`${API_BASE}/entries`);
    const entries = await res.json();

    if (entries.length === 0) {
      listEl.innerHTML = '<p class="empty">No entries yet. Be the first!</p>';
      return;
    }

    listEl.innerHTML = '';
    [...entries].reverse().forEach(entry => {
      const el = document.createElement('div');
      el.className = 'entry';
      el.innerHTML = `
        <div class="entry-header">
          <span class="entry-name">${escapeHtml(entry.name)}</span>
          <span class="entry-date">${entry.date}</span>
        </div>
        <div class="entry-message">${escapeHtml(entry.message)}</div>
      `;
      listEl.appendChild(el);
    });
  } catch {
    listEl.innerHTML = '<p class="empty">Could not load entries.</p>';
  }
}

form.addEventListener('submit', async (e) => {
  e.preventDefault();
  errorEl.textContent = '';

  const name    = document.getElementById('input-name').value.trim();
  const message = document.getElementById('input-message').value.trim();
  const btn     = form.querySelector('button');

  btn.disabled = true;
  btn.textContent = 'Posting...';

  try {
    const res = await fetch(`${API_BASE}/entries`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name, message })
    });

    if (!res.ok) {
      const err = await res.json();
      errorEl.textContent = err.error || 'Something went wrong.';
      return;
    }

    form.reset();
    await loadEntries();
  } catch {
    errorEl.textContent = 'Could not reach the API.';
  } finally {
    btn.disabled = false;
    btn.textContent = 'Post Entry';
  }
});

// check for Cross-Site Scripting (somewone writes <script>alert('xss')</script> in the guestbook)
function escapeHtml(str) {
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

ping();
loadEntries();