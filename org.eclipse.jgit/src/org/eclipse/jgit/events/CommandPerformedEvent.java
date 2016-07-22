package org.eclipse.jgit.events;

/**
 * Describes successful command completion.
 *
 * @author Alexander Kozinko
 */
public class CommandPerformedEvent
		extends RepositoryEvent<CommandPerformedListener> {

	private Class<?> type;

	/**
	 *
	 * @param type
	 *            Type of command
	 */
	public CommandPerformedEvent(Class<?> type) {
		super();
		this.type = type;
	}

	@Override
	public Class<CommandPerformedListener> getListenerType() {
		return CommandPerformedListener.class;
	}

	@Override
	public void dispatch(CommandPerformedListener listener) {
		listener.onOperationPerformed(this);
	}

	/**
	 * @return type of performed command
	 */
	public Class<?> getCommandType() {
		return type;
	}
}
