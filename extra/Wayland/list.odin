package wayland

wl_list :: struct {
  prev: ^wl_list,
  next: ^wl_list
}

wl_list_init: proc "c" (list: ^wl_list)

/**
 * Inserts an element into the list, after the element represented by \p list.
 * When \p list is a reference to the list itself (the head), set the containing
 * struct of \p elm as the first element in the list.
 *
 * \note If \p elm is already part of a list, inserting it again will lead to
 *       list corruption.
 *
 * \param list List element after which the new element is inserted
 * \param elm Link of the containing struct to insert into the list
 *
 * \memberof wl_list
 */
void
wl_list_insert(struct wl_list *list, struct wl_list *elm);

/**
 * Removes an element from the list.
 *
 * \note This operation leaves \p elm in an invalid state.
 *
 * \param elm Link of the containing struct to remove from the list
 *
 * \memberof wl_list
 */
void
wl_list_remove(struct wl_list *elm);

/**
 * Determines the length of the list.
 *
 * \note This is an O(n) operation.
 *
 * \param list List whose length is to be determined
 *
 * \return Number of elements in the list
 *
 * \memberof wl_list
 */
int
wl_list_length(const struct wl_list *list);

/**
 * Determines if the list is empty.
 *
 * \param list List whose emptiness is to be determined
 *
 * \return 1 if empty, or 0 if not empty
 *
 * \memberof wl_list
 */
int
wl_list_empty(const struct wl_list *list);

/**
 * Inserts all of the elements of one list into another, after the element
 * represented by \p list.
 *
 * \note This leaves \p other in an invalid state.
 *
 * \param list List element after which the other list elements will be inserted
 * \param other List of elements to insert
 *
 * \memberof wl_list
 */
void
wl_list_insert_list(struct wl_list *list, struct wl_list *other);

/**
 * Retrieves a pointer to a containing struct, given a member name.
 *
 * This macro allows "conversion" from a pointer to a member to its containing
 * struct. This is useful if you have a contained item like a wl_list,
 * wl_listener, or wl_signal, provided via a callback or other means, and would
 * like to retrieve the struct that contains it.
 *
 * To demonstrate, the following example retrieves a pointer to
 * `example_container` given only its `destroy_listener` member:
 *
 * \code
 * struct example_container {
 *         struct wl_listener destroy_listener;
 *         // other members...
 * };
 *
 * void example_container_destroy(struct wl_listener *listener, void *data)
 * {
 *         struct example_container *ctr;
 *
 *         ctr = wl_container_of(listener, ctr, destroy_listener);
 *         // destroy ctr...
 * }
 * \endcode
 *
 * \note `sample` need not be a valid pointer. A null or uninitialised pointer
 *       is sufficient.
 *
 * \param ptr Valid pointer to the contained member
 * \param sample Pointer to a struct whose type contains \p ptr
 * \param member Named location of \p ptr within the \p sample type
 *
 * \return The container for the specified pointer
 */
#define wl_container_of(ptr, sample, member)        \
  (__typeof__(sample))((char *)(ptr) -        \
           offsetof(__typeof__(*sample), member))

/**
 * Iterates over a list.
 *
 * This macro expresses a for-each iterator for wl_list. Given a list and
 * wl_list link member name (often named `link` by convention), this macro
 * assigns each element in the list to \p pos, which can then be referenced in
 * a trailing code block. For example, given a wl_list of `struct message`
 * elements:
 *
 * \code
 * struct message {
 *         char *contents;
 *         wl_list link;
 * };
 *
 * struct wl_list *message_list;
 * // Assume message_list now "contains" many messages
 *
 * struct message *m;
 * wl_list_for_each(m, message_list, link) {
 *         do_something_with_message(m);
 * }
 * \endcode
 *
 * \param pos Cursor that each list element will be assigned to
 * \param head Head of the list to iterate over
 * \param member Name of the link member within the element struct
 *
 * \relates wl_list
 */
#define wl_list_for_each(pos, head, member)        \
  for (pos = wl_container_of((head)->next, pos, member);  \
       &pos->member != (head);          \
       pos = wl_container_of(pos->member.next, pos, member))

/**
 * Iterates over a list, safe against removal of the list element.
 *
 * \note Only removal of the current element, \p pos, is safe. Removing
 *       any other element during traversal may lead to a loop malfunction.
 *
 * \sa wl_list_for_each()
 *
 * \param pos Cursor that each list element will be assigned to
 * \param tmp Temporary pointer of the same type as \p pos
 * \param head Head of the list to iterate over
 * \param member Name of the link member within the element struct
 *
 * \relates wl_list
 */
#define wl_list_for_each_safe(pos, tmp, head, member)      \
  for (pos = wl_container_of((head)->next, pos, member),    \
       tmp = wl_container_of((pos)->member.next, tmp, member);  \
       &pos->member != (head);          \
       pos = tmp,              \
       tmp = wl_container_of(pos->member.next, tmp, member))

/**
 * Iterates backwards over a list.
 *
 * \sa wl_list_for_each()
 *
 * \param pos Cursor that each list element will be assigned to
 * \param head Head of the list to iterate over
 * \param member Name of the link member within the element struct
 *
 * \relates wl_list
 */
#define wl_list_for_each_reverse(pos, head, member)      \
  for (pos = wl_container_of((head)->prev, pos, member);  \
       &pos->member != (head);          \
       pos = wl_container_of(pos->member.prev, pos, member))

/**
 * Iterates backwards over a list, safe against removal of the list element.
 *
 * \note Only removal of the current element, \p pos, is safe. Removing
 *       any other element during traversal may lead to a loop malfunction.
 *
 * \sa wl_list_for_each()
 *
 * \param pos Cursor that each list element will be assigned to
 * \param tmp Temporary pointer of the same type as \p pos
 * \param head Head of the list to iterate over
 * \param member Name of the link member within the element struct
 *
 * \relates wl_list
 */
#define wl_list_for_each_reverse_safe(pos, tmp, head, member)    \
  for (pos = wl_container_of((head)->prev, pos, member),  \
       tmp = wl_container_of((pos)->member.prev, tmp, member);  \
       &pos->member != (head);          \
       pos = tmp,              \
       tmp = wl_container_of(pos->member.prev, tmp, member))
