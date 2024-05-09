if (!HTMLElement.prototype.hasOwnProperty("___elm-radix-ui-tooltip")) {
  Object.defineProperty(HTMLElement.prototype, "___elm-radix-ui-tooltip", {
    set() {
      retry(() => {
        const target = this.previousElementSibling;
        const tooltipArrow = this.querySelector(".rt-TooltipArrow");
        const tooltipContent = this.firstChild;

        target.addEventListener("mouseover", () => {
          if (!this.matches(":popover-open")) {
            this.showPopover();

            const targetRect = target.getBoundingClientRect();
            const thisRect = this.getBoundingClientRect();
            const tooltipContentRect = tooltipContent.getBoundingClientRect();

            const top = targetRect.top - thisRect.height - 6;
            const desiredLeft =
              targetRect.left + targetRect.width / 2 - thisRect.width / 2 + 3;
            const left = Math.max(3, desiredLeft);

            //   Set CSS variables
            this.style.setProperty(
              "--radix-popper-transform-origin",
              top - 5 + "px " + left + "px",
            );
            this.style.setProperty(
              "--radix-popper-available-width",
              window.innerWidth - thisRect.width + "px",
            );
            this.style.setProperty(
              "--radix-popper-available-height",
              window.innerHeight - thisRect.height + "px",
            );
            this.style.setProperty(
              "--radix-popper-anchor-width",
              targetRect.width + "px",
            );
            this.style.setProperty(
              "--radix-popper-anchor-height",
              targetRect.height + "px",
            );

            // Set position
            this.style.top = top + "px";
            this.style.left = left + "px";

            tooltipArrow.style.top = top + thisRect.height - 3 + "px";
            tooltipArrow.style.left =
              targetRect.left - 3 + targetRect.width / 2 + "px";

            console.log("Pos set");
          }
        });
        target.addEventListener("mouseout", () => {
          if (this.matches(":popover-open")) {
            this.hidePopover();
          }
        });
      });
    },
  });
}
