
document.getElementById('prev-button').addEventListener('click', (e) => {
  const date = getDate();
  date.setDate(date.getDate() - 1);
  setDate(date);
  e.target.closest('form').submit();
});

document.getElementById('next-button').addEventListener('click', (e) => {
  const date = getDate();
  date.setDate(date.getDate() + 1);
  setDate(date);
  e.target.closest('form').submit();
});


function getDate() {
  const dateStr = document.getElementById('date').value;
  const result = /(\d{4})-(\d{2})-(\d{2})/.exec(dateStr);
  if (result) {
    return new Date(result[1], parseInt(result[2]) -1, result[3]);
  }
  return new Date();
}

function setDate(date) {
  document.getElementById('date').value = date2str(date);
}

function date2str(date) {
  return `${date.getFullYear()}-${zeroPadding(date.getMonth() + 1, 2)}-${zeroPadding(date.getDate(), 2)}`;
}

function zeroPadding(number, length) {
  return ('0'.repeat(length) + number).slice(- length);
}