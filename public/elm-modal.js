if (!HTMLDialogElement.prototype.hasOwnProperty("___elm-radix-ui-open")) {
  Object.defineProperty(HTMLDialogElement.prototype, "___elm-radix-ui-open", {
    set(isOpen) {
      if (isOpen) {
        retry(() => this.showModal());
      } else {
        this.close(this.getAttribute("returnValue"));
      }
    },
  });
}
