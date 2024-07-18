/************************************
 * TOOLTIP
 ************************************/

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
                        const tooltipContentRect =
                            tooltipContent.getBoundingClientRect();

                        const top = targetRect.top - thisRect.height - 6;
                        const desiredLeft =
                            targetRect.left +
                            targetRect.width / 2 -
                            thisRect.width / 2 +
                            3;
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

                        tooltipArrow.style.top =
                            top + thisRect.height - 3 + "px";
                        tooltipArrow.style.left =
                            targetRect.left - 3 + targetRect.width / 2 + "px";
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

/************************************
 * SELECT
 ************************************/

if (!HTMLElement.prototype.hasOwnProperty("___elm-radix-ui-select-list")) {
    Object.defineProperty(
        HTMLElement.prototype,
        "___elm-radix-ui-select-list",
        {
            set({ isPopoverStyle, value }) {
                if (this.style.top === "") {
                    var self = this;

                    // This, and its reset at the end, fixes blurring the focused value
                    self.style.setProperty("pointer-events", "none");
                    // This, and its reset at the end, fixes jitter
                    self.style.setProperty("opacity", "0");

                    requestAnimationFrame(() =>
                        retry(() => {
                            if (self.parentElement) {
                                const trigger = self.parentElement;
                                const triggerRect =
                                    trigger.getBoundingClientRect();
                                const thisRect = self.getBoundingClientRect();

                                if (isPopoverStyle) {
                                    // position the top left corner of the item list
                                    // at the bottom left corner of the trigger
                                    self.style.setProperty(
                                        "top",
                                        triggerRect.bottom + "px",
                                    );
                                    self.style.setProperty(
                                        "left",
                                        triggerRect.left + "px",
                                    );
                                } else {
                                    // position the item list horizontally centered on the trigger
                                    // and vertically the current value should be centered on the trigger
                                    console.log("CARL", value);
                                    const initallyFocusedElement =
                                        self.querySelector(
                                            `[data-select-option-value="${value}"]`,
                                        );
                                    const initallyFocusedRect =
                                        initallyFocusedElement?.getBoundingClientRect();
                                    const triggerCenter =
                                        triggerRect.top +
                                        triggerRect.height / 2;
                                    const initallyFocusedCenter =
                                        initallyFocusedRect
                                            ? initallyFocusedRect.top +
                                              initallyFocusedRect.height / 2
                                            : 0;
                                    const top = initallyFocusedElement
                                        ? thisRect.top +
                                          triggerCenter -
                                          initallyFocusedCenter
                                        : triggerCenter - thisRect.height / 2;

                                    self.style.setProperty("top", top + "px");
                                    self.style.setProperty(
                                        "left",
                                        Math.max(
                                            0,
                                            triggerRect.left +
                                                triggerRect.width / 2 -
                                                thisRect.width / 2,
                                        ) + "px",
                                    );
                                }

                                self.style.setProperty(
                                    "pointer-events",
                                    "initial",
                                );
                                self.style.setProperty("opacity", "1");
                            }
                        }),
                    );
                }
            },
        },
    );
}
