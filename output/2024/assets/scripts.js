document.addEventListener('DOMContentLoaded', function() {
  // Initialize all progress bars
  document.querySelectorAll('.progress-bar').forEach(bar => {
    const percentage = bar.dataset.percentage;
    const fill = bar.querySelector('.progress-bar-fill');
    fill.style.width = `${percentage}%`;
  });

  // Initialize charts if Chart.js is available
  if (typeof Chart !== 'undefined') {
    initializeCharts();
  }
});

function initializeCharts() {
  // Anomalies per part chart
  const partCtx = document.getElementById('anomaliesPerPartChart');
  if (partCtx) {
    new Chart(partCtx, {
      type: 'bar',
      data: {
        labels: ['Dancing Part', 'Acrobatic Part'],
        datasets: [{
          label: 'Number of Anomalies',
          data: [
            parseInt(document.getElementById('danceAnomalies').textContent),
            parseInt(document.getElementById('acroAnomalies').textContent)
          ],
          backgroundColor: [
            'rgba(52, 152, 219, 0.8)',
            'rgba(46, 204, 113, 0.8)'
          ]
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    });
  }

  // Anomalies per criteria chart
  const criteriaCtx = document.getElementById('anomaliesPerCriteriaChart');
  if (criteriaCtx) {
    const criteriaData = JSON.parse(criteriaCtx.dataset.criteria);
    new Chart(criteriaCtx, {
      type: 'bar',
      data: {
        labels: criteriaData.map(item => item.criteria),
        datasets: [{
          label: 'Percentage of Anomalies',
          data: criteriaData.map(item => item.percentage),
          backgroundColor: 'rgba(52, 152, 219, 0.8)'
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true,
            max: 100
          }
        }
      }
    });
  }
}

// Add smooth scrolling for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    document.querySelector(this.getAttribute('href')).scrollIntoView({
      behavior: 'smooth'
    });
  });
}); 