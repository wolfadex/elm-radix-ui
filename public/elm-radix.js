let documentLoaded = document.readyState !== "loading";
let toExecuteOnLoad = [];

document.addEventListener("DOMContentLoaded", () => {
  documentLoaded = true;

  for (const fn of toExecuteOnLoad) {
    retry(fn);
  }
});

function retry(fn, retries = 3) {
  if (documentLoaded) {
    try {
      fn();
    } catch (error) {
      if (retries > 0) {
        requestAnimationFrame(() => retry(fn, retries - 1));
      }
      throw error;
    }
  } else {
    toExecuteOnLoad.push(fn);
  }
}
