if (!HTMLDialogElement.prototype.hasOwnProperty("___elm-radix-ui-open")) {
  let documentLoaded = document.readyState !== "loading";
  let toExecuteOnLoad = null;

  Object.defineProperty(HTMLDialogElement.prototype, "___elm-radix-ui-open", {
    set(isOpen) {
      if (isOpen) {
        retry(() => this.showModal());
      } else {
        this.close(this.getAttribute("returnValue"));
      }
    },
  });

  document.addEventListener("DOMContentLoaded", () => {
    documentLoaded = true;

    if (toExecuteOnLoad !== null) {
      retry(toExecuteOnLoad);
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
      toExecuteOnLoad = fn;
    }
  }
}