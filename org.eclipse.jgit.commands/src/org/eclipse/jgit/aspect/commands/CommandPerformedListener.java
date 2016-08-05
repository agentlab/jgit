package org.eclipse.jgit.aspect.commands;

import org.eclipse.jgit.events.RepositoryListener;

/**
 * Listens to {@link CommandPerformedEvent}
 *
 * @author Alexander Kozinko
 * @since 4.4
 */
public interface CommandPerformedListener extends RepositoryListener {

	/**
	 * Invoked when operation is performed.
	 *
	 * @param event
	 *            information about event
	 */
	void onOperationPerformed(CommandPerformedEvent event);
}