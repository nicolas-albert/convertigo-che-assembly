package org.eclipse.che.plugin.convertigo.properties.ide.view;

import org.eclipse.che.ide.api.mvp.View;
import org.eclipse.che.ide.api.parts.base.BaseActionDelegate;

public interface PropertiesView extends View<PropertiesView.ActionDelegate> {

	interface ActionDelegate extends BaseActionDelegate {
    }
}
