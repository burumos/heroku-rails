
document.getElementById('add-condtion')?.addEventListener('click', async () => {
  const formData = new FormData(document.getElementById('nico-search-form'));
  const { data } = await api('/nico/condition', 'POST', formData);
  addCondtionRow(data);
});


(JSON.parse(document.getElementById('condition-list').dataset.conditions || '') || []).forEach(condition => addCondtionRow(condition));
document.querySelectorAll('#condition-list .apply-button').forEach(elem => elem.addEventListener('click', handleApplyCondition));
document.querySelectorAll('#condition-list .delete-button').forEach(elem => elem.addEventListener('click', handleDeleteCondition));

function handleApplyCondition(event) {
  const row = event.target.closest('.condition-row');
  const { query, limit, minimumViews } = row.dataset; 
  document.getElementById('query').value = query;
  document.getElementById('limit').value = limit;
  document.getElementById('minimum_views').value = minimumViews;
  document.querySelector('input[type="submit"]').click();
}

async function handleDeleteCondition(event) {
  event.stopPropagation();
  event.preventDefault();
  if (!confirm('指定の検索条件を削除してよろしいですか？')) return;
  const row = event.target.closest('.condition-row');
  const id = row.dataset.id;
  await deleteCondition(id);
  row.remove();
}

function addCondtionRow(condition) {
  const { id, query, limit, minimum_views: minimumViews } = condition;
  const row = document.getElementById('condition-row-format').cloneNode(true);
  row.removeAttribute('id');
  row.dataset.id = id;
  row.dataset.query = query;
  row.dataset.limit = limit;
  row.dataset.minimumViews = minimumViews;
  row.querySelector('.query').innerText = query;
  row.querySelector('.limit').innerText = limit;
  row.querySelector('.minimum-views').innerText = minimumViews;
  row.querySelector('.apply-button').addEventListener('click', handleApplyCondition);
  row.querySelector('.delete-button').addEventListener('click', handleDeleteCondition);
  document.getElementById('condition-list').append(row);
  return row;
}

async function deleteCondition(id) {
  return await api(`/nico/condition/${id}`, 'DELETE');
}

async function api(url, method, dataForm) {
  try {
    const response = await fetch(url, {
      method: method,
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: dataForm,
    });
    if (response.ok) {
      return response.json();
    }
    throw new Error('API Error');
  } catch (error) {
    alert(`Error`);
    console.error(error);
    throw error;
  }
}
