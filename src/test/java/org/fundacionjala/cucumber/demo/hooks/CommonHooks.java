package org.fundacionjala.cucumber.demo.hooks;

import org.fundacionjala.cucumber.demo.context.Context;

/**
 * Groups common preconditions and post conditions methods.
 */
public class CommonHooks {

    private Context context;

    /**
     * Initializes an instance of CommonHooks class.
     *
     * @param context scenario context object.
     */
    public CommonHooks(final Context context) {
        this.context = context;
    }
}
