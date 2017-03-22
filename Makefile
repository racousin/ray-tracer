NAME		=	rt

SRCS_PATH	=	srcs

SRCS_NAME	=	main.c										\
				renderer/compute_image.c					\
				renderer/camera.c							\
				renderer/maths/vec3_norm.c					\
				renderer/maths/vec3_op.c					\
				renderer/maths/solve.c						\
				renderer/maths/solve_quad.c					\
				renderer/maths/minimal_positiv_dist.c		\
				renderer/objects/sphere.c					\
				renderer/objects/polygon.c					\
				renderer/objects/torus.c					\
				renderer/objects/cylinder.c					\
				renderer/objects/cone.c						\
				renderer/objects/plane.c					\
				renderer/objects/disk.c						\
				renderer/objects/csg.c						\
				renderer/objects/csg_union.c				\
				renderer/objects/csg_inter.c				\
				renderer/objects/csg_minus.c				\
				renderer/objects/csg_minus2.c				\
				renderer/objects/object_selection.c			\
				ui/create_object.c							\
				ui/display_panel.c							\
				ui/left_panel/add_buttons.c					\
				ui/left_panel/left_panel.c					\
				ui/obj_tree.c								\
				ui/right_panel/selected_el_properties.c		\
				ui/right_panel/cam_properties.c				\
				ui/right_panel/right_panel.c				\
				ui/right_panel/scene_properties.c			\
				ui/right_panel/color_chooser.c				\
				ui/tools/dtoa.c								\
				ui/tools/type_char.c						\
				ui/menu_keys.c								\
				ui/realtime_keys.c							\
				ui/widgets/numeric_entry.c					\
				ui/widgets/scale_entry.c					\
				ui/widgets/text_entry.c						\
				ui/widgets/vector3_entry.c					\
				ui/window.c									\
				ui/ui_print_scene.c							\
				ui/top_menu/top_menu.c						\
				converter/converter.c						\
				parsers/file_saver/file_saver.c				\
				parsers/file_saver/saver_tools.c			\
				parsers/file_loader/file_loader.c			\
				parsers/file_loader/parser.c				\
				parsers/file_loader/object.c				\
				parsers/file_loader/object2.c				\
				parsers/file_loader/camera.c				\
				parsers/file_loader/tools.c					\
				parsers/file_loader/vec3.c					\
				parsers/obj_loader/parsing.c				\
				parsers/obj_loader/obj_loader.c				\
				parsers/texture_loader.c					\

OBJS_NAME 	= 	$(SRCS_NAME:.c=.o)

OBJS_PATH	=	./objs
LFT_PATH	=	./libs/libft
INCS_PATH	=	./includes

GTK_CFLAGS	=	$(shell pkg-config --cflags gtk+-3.0)
GTK_CLIBS	=	$(shell pkg-config --libs gtk+-3.0)

CC			=	gcc -fdiagnostics-color=auto

CFLAGS		=	-g -I$(LFT_PATH) -I$(INCS_PATH) -I$(INCS_PATH)/ui -I$(INCS_PATH)/renderer -I$(INCS_PATH)/converter -I$(INCS_PATH)/parsers -Wall -Wextra
CFLAGS		+=	$(GTK_CFLAGS)

CLIBS		=	-lm -lpthread -L$(LFT_PATH) -lft
CLIBS		+=	$(GTK_CLIBS)

SRCS		=	$(addprefix $(SRCS_PATH)/,$(SRCS_NAME))
OBJS		=	$(addprefix $(OBJS_PATH)/,$(OBJS_NAME))

all: $(NAME)

$(NAME): 		$(OBJS)
				make -C $(LFT_PATH)
				gcc $^ -o $@ $(CLIBS)

$(OBJS_PATH)/%.o: $(SRCS_PATH)/%.c
				@mkdir $(OBJS_PATH) 2> /dev/null || true
				@mkdir $(OBJS_PATH)/converter 2> /dev/null || true
				@mkdir $(OBJS_PATH)/renderer 2> /dev/null || true
				@mkdir $(OBJS_PATH)/renderer/maths 2> /dev/null || true
				@mkdir $(OBJS_PATH)/renderer/objects 2> /dev/null || true
				@mkdir $(OBJS_PATH)/ui 2> /dev/null || true
				@mkdir $(OBJS_PATH)/ui/left_panel 2> /dev/null || true
				@mkdir $(OBJS_PATH)/ui/right_panel 2> /dev/null || true
				@mkdir $(OBJS_PATH)/ui/tools 2> /dev/null || true
				@mkdir $(OBJS_PATH)/ui/widgets 2> /dev/null || true
				@mkdir $(OBJS_PATH)/ui/top_menu 2> /dev/null || true
				@mkdir $(OBJS_PATH)/parsers 2> /dev/null || true
				@mkdir $(OBJS_PATH)/parsers/file_loader 2> /dev/null || true
				@mkdir $(OBJS_PATH)/parsers/file_saver 2> /dev/null || true
				@mkdir $(OBJS_PATH)/parsers/obj_loader 2> /dev/null || true
				$(CC) -o $@ -c $< $(CFLAGS)

clean:
				rm -rf $(OBJS)
				@rm -rf $(OBJS_PATH) 2> /dev/null || true
				make -C $(LFT_PATH) clean

fclean:
				rm -rf $(OBJS)
				rm -rf $(NAME)
				@rm -rf $(OBJS_PATH) 2> /dev/null || true
				make -C $(LFT_PATH) fclean

re: 			fclean all
