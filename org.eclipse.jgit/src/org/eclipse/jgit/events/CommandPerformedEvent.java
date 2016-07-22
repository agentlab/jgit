package org.eclipse.jgit.events;

/**
 * Describes successful command completion.
 *
 * @author Alexander Kozinko
 */
public class CommandPerformedEvent
		extends RepositoryEvent<CommandPerformedListener> {

	private Class<?> type;

	private Object result;

	/**
	 *
	 * @param type
	 *            Type of command
	 * @param result
	 *            Result of command
	 */
	public CommandPerformedEvent(Class<?> type, Object result) {
		super();
		this.type = type;
		this.result = result;
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

	/**
	 *
	 * @return The result of performed command
	 */
	public Object getResult() {
		return result;
	}
}
