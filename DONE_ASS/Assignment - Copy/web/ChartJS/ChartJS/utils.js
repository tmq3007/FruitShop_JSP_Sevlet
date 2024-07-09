export const MONTHS = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

export function randomInteger(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}
