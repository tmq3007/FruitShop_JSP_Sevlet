import { MONTHS, randomInteger } from "./utils.js";

Chart.register(ChartDataLabels);

const labels = MONTHS.slice(0, 6);

const allCanvas = document.querySelectorAll("canvas");

allCanvas.forEach((el) => {
  const { type, colorDatalabels } = el.dataset;

  const data = {
    labels: labels,
    datasets: [
      {
        label: "Analyze site traffic",
        backgroundColor: "rgb(255, 99, 132)",
        borderColor: "rgb(255, 99, 132)",
        data: Array.from({ length: labels.length }).map(() =>
          randomInteger(100, 500)
        ),
        tension: 0.2,
      },
    ],
  };

  const config = {
    type: el.dataset.type,
    data: data,
    options: {
      aspectRatio: 16 / 9,
      layout: {
        padding: 20,
      },
      plugins: {
        tooltip: {
          titleFont: {
            size: 22,
          },
          bodyFont: {
            size: 22,
          },
          callbacks: {
            label: (context) => `Total: ${context.formattedValue} users`,
          },
        },
        datalabels: {
          color: colorDatalabels,
          font: { size: 18 },
          formatter: function (value, context) {
            return value;
          },
          display: function (context) {
            if (type === "line")
              return (
                context.dataIndex > 0 && context.dataIndex < labels.length - 1
              );

            return true;
          },
        },
      },
    },
  };

  new Chart(el, config);
});
